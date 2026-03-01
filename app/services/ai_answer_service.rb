class AiAnswerService
  SYSTEM_PROMPT = <<~PROMPT
    あなたは保険業務全般に精通した専門家です。
    ユーザーからの保険に関する質問に対して、正確で分かりやすい回答を提供してください。

    回答のルール:
    - 具体的な条文や約款の内容に基づいて回答する
    - 不確かな場合は「確認が必要です」と明記する
    - 専門用語は簡潔に説明を添える
    - 回答は日本語で行う
  PROMPT

  def initialize(question)
    @question = question
  end

  def call
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: SYSTEM_PROMPT },
          { role: "user", content: build_user_message }
        ],
        temperature: 0.3
      }
    )

    content = response.dig("choices", 0, "message", "content")
    @question.create_ai_answer!(content: content)
  rescue StandardError => e
    Rails.logger.error("AI Answer generation failed: #{e.message}")
    @question.create_ai_answer!(
      content: "申し訳ございません。現在AI回答の生成に問題が発生しています。しばらくしてから再度お試しください。"
    )
  end

  private

  def client
    @client ||= OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end

  def build_user_message
    "質問タイトル: #{@question.title}\n\n質問内容:\n#{@question.content}"
  end
end
