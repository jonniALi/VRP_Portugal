var audio_element = document.getElementById("cs_audio");
document.onkeydown = function(event) {
    switch (event.keyCode) {
       case 38:
            event.preventDefault();
            audio_vol = audio_element.volume;
            if (audio_vol!=1) {
              try {
                  audio_element.volume = audio_vol + 0.02;
              }
              catch(err) {
                  audio_element.volume = 1;
              }
              
            }
            
          break;
       case 40:
            event.preventDefault();
            audio_vol = audio_element.volume;
            if (audio_vol!=0) {
              try {
                  audio_element.volume = audio_vol - 0.02;
              }
              catch(err) {
                  audio_element.volume = 0;
              }
              
            }
            
          break;
    }
};