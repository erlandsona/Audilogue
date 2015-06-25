$(document).ready(function () {
  initializeAudioRecorder();
});




function initializeAudioRecorder() {
  (function() {
    var params = {},
        r = /([^&=]+)=?([^&]*)/g;

    function d(s) {
      return decodeURIComponent(s.replace(/\+/g, ' '));
    }

    var match, search = window.location.search;
    while (match = r.exec(search.substring(1))) {
      params[d(match[1])] = d(match[2]);
    }
    window.params = params;
  })();

  function getById (id) {
    return document.getElementById(id);
  }

  var audioContext = new AudioContext(),
      realAudioInput, inputPoint, audioRecorder,
      rafID,
      analyserContext,
      canvasWidth, canvasHeight,
      recordPauseAudio      = getById('record-pause-audio'),
      stopRecordingAudio    = getById('stop-recording-audio'),
      // audio                 = getById('audio'),
      saveAudio             = getById('sound_file'),
      audioStream,
      recorder;

  function drawBuffer( width, height, context, data ) {
    var step = Math.ceil( data.length / width );
    var amp = height / 2;
    context.fillStyle = "gold";
    context.clearRect(0,0,width,height);
    for(var i=0; i < width; i++){
      var min = 1.0;
      var max = -1.0;
      for (j=0; j<step; j++) {
        var datum = data[(i*step)+j];
        if (datum < min) min = datum;
        if (datum > max) max = datum;
      }
      context.fillRect(i,(1+min)*amp,1,Math.max(1,(max-min)*amp));
    }
  }

  // function toggleRecording( e ) {
  //   if (e.classList.contains("recording")) {
  //     // stop recording
  //     audioRecorder.stop();
  //     e.classList.remove("recording");
  //     audioRecorder.getBuffers( gotBuffers );
  //   } else {
  //     // start recording
  //     if (!audioRecorder)
  //         return;
  //     e.classList.add("recording");
  //     audioRecorder.clear();
  //     audioRecorder.record();
  //   }
  // }

  function gotBuffers( buffers ) {
    var canvas = getById("wavedisplay");
    drawBuffer( canvas.width, canvas.height, canvas.getContext('2d'), buffers[0] );

    // the ONLY time gotBuffers is called is right after a new recording is completed -
    // so here's where we should set up the download.
    // audioRecorder.exportWAV( doneEncoding );
  }

  function cancelAnalyserUpdates() {
    window.cancelAnimationFrame( rafID );
    rafID = null;
  }

  function updateAnalysers(time) {
    if (!analyserContext) {
      var canvas = getById("analyser");
      canvasWidth = canvas.width;
      canvasHeight = canvas.height;
      analyserContext = canvas.getContext('2d');
    }

    // analyzer draw code here
    {
      var SPACING = 3;
      var BAR_WIDTH = 1;
      var numBars = Math.round(canvasWidth / SPACING);
      var freqByteData = new Uint8Array(analyserNode.frequencyBinCount);

      analyserNode.getByteFrequencyData(freqByteData);

      analyserContext.clearRect(0, 0, canvasWidth, canvasHeight);
      analyserContext.fillStyle = '#F6D565';
      analyserContext.lineCap = 'round';
      var multiplier = analyserNode.frequencyBinCount / numBars;

        // Draw rectangle for each frequency bin.
      for (var i = 0; i < numBars; ++i) {
        var magnitude = 0;
        var offset = Math.floor( i * multiplier );
        // gotta sum/average the block, or we miss narrow-bandwidth spikes
        for (var j = 0; j < multiplier; j++) {
          magnitude += freqByteData[offset + j];
        }
        magnitude = magnitude / multiplier;
        var magnitude2 = freqByteData[i * multiplier];
        analyserContext.fillStyle = "hsl( " + Math.round((i*360)/numBars) + ", 100%, 50%)";
        analyserContext.fillRect(i * SPACING, canvasHeight, BAR_WIDTH, -magnitude);
      }
    }

    rafID = window.requestAnimationFrame( updateAnalysers );
  }


  recordPauseAudio.onclick = function() {
    if (!audioStream && !recorder) {
      navigator.getUserMedia({ audio: true, video: false }, function(stream) {
        if (window.IsChrome) {stream = new window.MediaStream(stream.getAudioTracks());}
        audioStream = stream;

        // "audio" is a default type
        recorder = window.RecordRTC(stream, {
          type: 'audio',
          bufferSize: typeof params.bufferSize == 'undefined' ? 16384 : params.bufferSize,
          sampleRate: typeof params.sampleRate == 'undefined' ? 44100 : params.sampleRate,
          leftChannel: params.leftChannel || false,
          disableLogs: params.disableLogs || false
        });
        recorder.startRecording();
        recordPauseAudio.innerHTML = "Pause"


        inputPoint = audioContext.createGain();

        // Create an AudioNode from the stream.
        realAudioInput = audioContext.createMediaStreamSource(stream);
        realAudioInput.connect(inputPoint);

        // audioInput = convertToMono( input );

        analyserNode = audioContext.createAnalyser();
        analyserNode.fftSize = 2048;
        inputPoint.connect( analyserNode );

        audioRecorder = new Recorder( inputPoint );

        zeroGain = audioContext.createGain();
        zeroGain.gain.value = 0.0;
        inputPoint.connect( zeroGain );
        zeroGain.connect( audioContext.destination );
        updateAnalysers();

      }, function(error) {
        alert('Error getting audio');
        console.log(error);
      });
    } else {
      if(this.innerHTML === 'Pause') {
        this.innerHTML = 'Resume';
        recorder.pauseRecording();
        return;
      }

      this.innerHTML = 'Pause';
      recorder.resumeRecording();

      // audio.src = URL.createObjectURL(audioStream);
      // audio.muted = true;
      // audio.play();
      // if (recorder) recorder.startRecording();
    }

    window.isAudio = true;

    // this.disabled = true;
    stopRecordingAudio.disabled = false;
  };

  stopRecordingAudio.onclick = function() {
    this.disabled = true;
    recordPauseAudio.disabled = false;
    // audio.src = '';

    if (recorder) {
      recorder.stopRecording(function(url) {
        var blob = recorder.getBlob();
        var formData = new FormData();
        formData.append('sound[file]', blob);
        formData.append('sound[title]', $('#sound_title').val());

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/sounds");
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        xhr.send(formData);
        xhr.onload = function (event) {
          $('#main').html(event.target.responseText);
          initializeAudioRecorder();
        }
      });
    }
  };
}


