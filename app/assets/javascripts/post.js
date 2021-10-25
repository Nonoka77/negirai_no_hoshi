$(function () {
	function createHTML(post) {
		let html = `<div class="post" id="post${post.id}">
                    <span class="post_name">${post.user.username}</span>
                    <a class="post_delete" rel="nofollow" data-method="delete" href="/posts/${post.id}">削除</a>
                    <p class="post_body">${post.content}</p>
                    </div>`;
		return html;
	}
	// メモ投稿(POSTメソッド)の処理
	$("#post_input").on("submit", function (e) {
		e.preventDefault();
		let inputText = $(".post_form-text").val(); // textareaの入力値を取得
		let url = $(this).attr("action"); // action属性のurlを抽出
		$.ajax({
			url: url,
			type: "POST",
			data: {
				post: { content: inputText },
			},
			dataType: "json", 
		})
			.done(function (data) {
				let html = createHTML(data); // 受信したデータ(data)を元に追加するURLを生成(createHTML関数は冒頭で定義)
				$(".posts").append(html); // 生成したHTMLをappendメソッドでドキュメントに追加
				$(".post_form-text").val(""); // textareaを空にする
			})
			.fail(function () {
				alert("error!"); // 通信に失敗した場合はアラートを表示
			})
			.always(function () {
				$(".post_form-btn").prop("disabled", false); // submitボタンのdisableを解除
				$(".post_form-btn").removeAttr("data-disable-with"); // submitボタンのdisableを解除(Rails5.0以降はこちらも必要)
			});
	});
	$(".posts").on("click", ".post_delete", function (e) {
		e.preventDefault(); 
		e.stopPropagation(); 
		let url = $(this).attr("href");
		$.ajax({
			url: url,
			type: "POST", 
			data: {
				_method: "delete",
			},
			dataType: "json",
		})
			.done(function (data) {
				$("#post" + data.id).remove(); 
			})
			.fail(function (XMLHttpRequest) {
				alert(XMLHttpRequest.status);
			});
	});
});
