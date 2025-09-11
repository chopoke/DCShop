<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	// Controller가 모델에 올려준 값(plugin key) 사용. // session에서 현재 사용자의 정보를 가져옴.
	window.__CHANNELIO_PLUGIN_KEY__ = '<c:out value="${CHANNELIO_PLUGIN_KEY}" />';
	window.__SESSION__ = {
		memberId : '<c:out value="${sessionScope.session_u_member_id}" />',
		name : '<c:out value="${sessionScope.session_u_nickname}" />',
		email : '<c:out value="${sessionScope.session_u_email}" />',
		mobileNumber : '<c:out value="${sessionScope.session_u_phone}" />'
	};
</script>

<!-- ChannelIO Loader (중복 로드 방지) -->
<script>
	(function() {
		var w = window;
		if (w.ChannelIO) {
			return;
		}
		var ch = function() {
			ch.c(arguments);
		};
		ch.q = [];
		ch.c = function(args) {
			ch.q.push(args);
		};
		w.ChannelIO = ch;
		function l() {
			if (w.ChannelIOInitialized)
				return;
			w.ChannelIOInitialized = true;
			var s = document.createElement("script");
			s.async = true;
			s.src = "https://cdn.channel.io/plugin/ch-plugin-web.js";
			var x = document.getElementsByTagName("script")[0];
			x && x.parentNode && x.parentNode.insertBefore(s, x);
		}
		if (document.readyState === "complete")
			l();
		else {
			w.addEventListener("DOMContentLoaded", l);
			w.addEventListener("load", l);
		}
	})();
</script>

<!-- Auto boot (화면이 불려올 때 실행. 언어 ko 고정) -->
<script>
(function () {
  var S = window.__SESSION__ || {};
	
  function bootWith(key) {
    if (!key) { console.error('[ChannelIO] pluginKey missing'); return; }
    window.ChannelIO('boot', {
      pluginKey: key,
      language: 'ko',   // 한국어로 고정
      memberId: S.memberId || undefined,
      profile: {
        name: S.name || undefined,
        email: S.email || undefined,
        mobileNumber: S.mobileNumber || undefined
      }
    }, function (err, user) {
      if (err) { console.error('boot error', err); return; }
      console.log('boot ok');
    });
  }

  function fetchKeyAndBoot() {
    var url = '<c:url value="/config" />'; // 컨텍스트 패스 자동 반영
    fetch(url, { credentials: 'same-origin' })
      .then(function (r) { if (!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function (cfg) { bootWith((cfg.pluginKey || '').trim()); })
      .catch(function (e) { console.error('[ChannelIO] fetch /config failed:', e); });
  }

  if (document.readyState === 'complete') fetchKeyAndBoot();
  else window.addEventListener('load', fetchKeyAndBoot);
})();
</script>
