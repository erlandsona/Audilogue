// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

(function() {
  var params = {},
      r = /([^&=]+)=?([^&]*)/g;

  function d(s) {
      return decodeURIComponent(s.replace(/\+/g, ' '));
  }

  var match, search = window.location.search;
  while (match = r.exec(search.substring(1)))
      params[d(match[1])] = d(match[2]);
  window.params = params;

})();


$(document).ready(function () {
  function getByID(id) {
      return document.getElementById(id);
  }

  var recordAudio = getByID('record-audio'),
      stopRecordingAudio = getByID('stop-recording-audio'),
      pauseResumeAudio = getByID('pause-resume-audio');

  var canvasWidth_input = getByID('canvas-width-input'),
      canvasHeight_input = getByID('canvas-height-input');

  if(params.canvas_width) {
      canvasWidth_input.value = params.canvas_width;
  }

  if(params.canvas_height) {
      canvasHeight_input.value = params.canvas_height;
  }

  var audio = getByID('audio');


  var audioConstraints = {
      audio: true,
      video: false
  };







  var audioStream;
  var recorder;

  recordAudio.onclick = function() {
      if (!audioStream)
          navigator.getUserMedia(audioConstraints, function(stream) {
              if (window.IsChrome) stream = new window.MediaStream(stream.getAudioTracks());
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
          }, function() {});
      else {
          audio.src = URL.createObjectURL(audioStream);
          audio.muted = true;
          audio.play();
          if (recorder) recorder.startRecording();
      }

      window.isAudio = true;

      this.disabled = true;
      stopRecordingAudio.disabled = false;
      pauseResumeAudio.disabled = false;
  };

  var screen_constraints;

  function isCaptureScreen(callback) {
      if (document.getElementById('record-screen').checked) {
          document.getElementById('fit-to-screen').onclick();

          getScreenId(function (error, sourceId, _screen_constraints) {
              if(error === 'not-installed') {
                  window.open('https://chrome.google.com/webstore/detail/screen-capturing/ajhifddimkapgcifgcodmmfdlknahffk');                        
              }

              if(error === 'permission-denied') {
                  alert('Screen capturing permission is denied.');
              }

              if(error === 'installed-disabled') {
                  alert('Please enable chrome screen capturing extension.');
              }

              callback();
          });
      }
      else {
          callback();
      }
  }

  stopRecordingAudio.onclick = function() {
      this.disabled = true;
      recordAudio.disabled = false;
      audio.src = '';

      if (recorder)
          recorder.stopRecording(function(url) {
              audio.src = url;
              audio.muted = false;
              audio.play();

              document.getElementById('audio-url-preview').innerHTML = '<a href="' + url + '" target="_blank">Recorded Audio URL</a>';
          });
  };

  pauseResumeAudio.onclick = function() {
      if(!recorder) return;

      if(this.innerHTML === 'Pause') {
          this.innerHTML = 'Resume';
          recorder.pauseRecording();
          return;
      }

      this.innerHTML = 'Pause';
      recorder.resumeRecording();
  };
});
