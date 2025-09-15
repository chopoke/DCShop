// /resources/js/editor.js
(function () {
  // TinyMCE CDN
  var API_KEY = 'jnbsg5gr6zjb5gr3ovnx9gdnl2svpazs29pqla8ft8kmz5o1';
  var TINY_SRC = 'https://cdn.tiny.cloud/1/' + API_KEY + '/tinymce/6/tinymce.min.js';

  function loadScriptOnce(src, cb, err) {
    if (window.tinymce) { cb(); return; }
    var s = document.createElement('script');
    s.src = src;
    s.referrerPolicy = 'origin';
    s.onload = cb;
    s.onerror = function(){ if (err) err(); };
    document.head.appendChild(s);
  }

  var DEFAULTS = {
    height: 500,
    menubar: false,
    convert_urls: false,
    plugins: 'link image table lists code',
    toolbar: 'undo redo | blocks | bold italic underline forecolor backcolor | ' +
             'alignleft aligncenter alignright | bullist numlist outdent indent | ' +
             'fontselect fontsizeselect | link image table | code',
    fontsize_formats: '12px 14px 16px 18px 20px 24px 28px 32px',
    content_style:
      '@import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap");' +
      'body{font-family:"Noto Sans KR",sans-serif;font-size:16px;}' +
      'img{max-width:100%;height:auto;}',
    block_formats: '본문=p; 제목 1=h1; 제목 2=h2; 제목 3=h3; 인용문=blockquote; 코드=pre',
    font_family_formats:
      'Noto Sans KR=Noto Sans KR,sans-serif; Pretendard=Pretendard,system-ui,sans-serif; ' +
      '맑은 고딕=Malgun Gothic,sans-serif; 바탕=Batang,serif; 돋움=Dotum,sans-serif;',
    image_title: true,
    file_picker_types: 'image'
  };

  function initOne(el) {
    var uploadUrl = el.getAttribute('data-upload');
    if (!uploadUrl) { return; }

    var height = parseInt(el.getAttribute('data-height') || DEFAULTS.height, 10);
    var toolbar = el.getAttribute('data-toolbar') || DEFAULTS.toolbar;
    var plugins = el.getAttribute('data-plugins') || DEFAULTS.plugins;

    var cfg = {
      selector: '#' + el.id,
      height: height,
      menubar: DEFAULTS.menubar,
      convert_urls: DEFAULTS.convert_urls,
      plugins: plugins,
      toolbar: toolbar,
      fontsize_formats: DEFAULTS.fontsize_formats,
      content_style: DEFAULTS.content_style,
      block_formats: DEFAULTS.block_formats,
      font_family_formats: DEFAULTS.font_family_formats,
      image_title: DEFAULTS.image_title,
      file_picker_types: DEFAULTS.file_picker_types
    };

    cfg.images_upload_handler = function (blobInfo, success, failure, progress) {
      try {
        var fd = new FormData();
        fd.append('file', blobInfo.blob(), blobInfo.filename());

        var xhr = new XMLHttpRequest();
        xhr.open('POST', uploadUrl);

        xhr.upload.onprogress = function (e) {
          if (e.lengthComputable && typeof progress === 'function') {
            progress(e.loaded / e.total * 100);
          }
        };
        xhr.onload = function () {
          if (xhr.status === 200) {
            try {
              var json = JSON.parse(xhr.responseText);
              success(json.location);
            } catch (e2) {
              failure('Invalid JSON');
            }
          } else {
            failure('HTTP ' + xhr.status);
          }
        };
        xhr.onerror = function () { failure('업로드 오류'); };
        xhr.send(fd);
      } catch (e) {
        failure('예외: ' + e.message);
      }
    };

    cfg.file_picker_callback = function (cb) {
      var input = document.createElement('input');
      input.type = 'file';
      input.accept = 'image/*';
      input.onchange = function () {
        var file = input.files[0];
        if (!file) { return; }

        var fd = new FormData();
        fd.append('file', file, file.name);

        var xhr = new XMLHttpRequest();
        console.log(uploadUrl);
        xhr.open('POST', uploadUrl);
        
        xhr.onload = function () {
          if (xhr.status === 200) {
            try {
              var json = JSON.parse(xhr.responseText);
              cb(json.location, { title: file.name });
            } catch (e3) {
              alert('Invalid JSON');
            }
          } else {
            alert('이미지 업로드 실패: ' + xhr.status);
          }
        };
        xhr.onerror = function(){ alert('이미지 업로드 에러'); };
        xhr.send(fd);
      };
      input.click();
    };

    tinymce.init(cfg);
  }

  function uniqueFormsFromTargets(targets) {
    var arr = [];
    for (var i = 0; i < targets.length; i++) {
      var f = targets[i].form;
      if (!f) { continue; }
      var exists = false;
      for (var j = 0; j < arr.length; j++) {
        if (arr[j] === f) { exists = true; break; }
      }
      if (!exists) { arr.push(f); }
    }
    return arr;
  }

  function initAll() {
    var targets = document.querySelectorAll('textarea[data-editor="tinymce"]');
    if (!targets || targets.length === 0) { return; }

    // id 없는 textarea에 id 부여
    for (var i = 0; i < targets.length; i++) {
      if (!targets[i].id) {
        targets[i].id = 'tinymce_' + Math.random().toString(36).substr(2);
      }
    }

    loadScriptOnce(TINY_SRC, function () {
      for (var k = 0; k < targets.length; k++) {
        initOne(targets[k]);
      }
      // submit 시 내용 동기화
      var forms = uniqueFormsFromTargets(targets);
      for (var m = 0; m < forms.length; m++) {
        (function (form) {
          form.addEventListener('submit', function () {
            if (window.tinymce) { tinymce.triggerSave(); }
          });
        })(forms[m]);
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAll);
  } else {
    initAll();
  }
})();