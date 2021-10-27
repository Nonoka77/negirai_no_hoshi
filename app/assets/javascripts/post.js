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
$(function () {
	$(document).on("click",".js-edit-button", function() {
		const postId = $(this).data('post-id');
		const postTextArea = $('#js-textarea-post-' + postId);
		const postButton = $('#js-post-button-' + postId);

		postTextArea.show();
		postButton.show();
	});
});
$(function () {
	$(document).on("click", ".post-cancel-button", function() {
		const postId = $(this).data('cancel-id');
		const postTextArea = $('#js-textarea-post-' + postId);
		const postButton = $('#js-post-button-' + postId);
		const postError = $('#js-post-error-' + postId)

		postTextArea.hide();
		postButton.hide();
		postError.hide();
	});
});
$(function () {
	$(document).on("click", ".post-update-button", function() {
		const postId = $(this).data('update-id');
		const textField = $('#js-textarea-post-' + postId);
		const content = textField.val();
		console.log(content);

		$.ajax({
			url: '/posts/' + postId,
			type: 'PATCH',
			data: {
				post: {
					content: content
				}
			},
		})
		.done(function (data) {
			const postTextField = $('#post_body' + postId);
			const postTextArea = $('#js-textarea-post-' + postId);
			const postButton = $('#js-post-button-' + postId);
			const postError = $('#js-post-error-' + postId);

			postTextField.text(data.content);
			postTextArea.hide();
			postButton.hide();
			postError.hide();
		})
		.fail(function () {
			const postError = $('#js-post-error-' + postId);
			postError.text('メッセージを入力してください')
		})
	});
});