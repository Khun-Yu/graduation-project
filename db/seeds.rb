# テストユーザー作成
user1 = User.find_or_create_by!(email: "tanaka@example.com") do |user|
  user.name = "田中太郎"
  user.password = "password123"
  user.password_confirmation = "password123"
end

user2 = User.find_or_create_by!(email: "suzuki@example.com") do |user|
  user.name = "鈴木花子"
  user.password = "password123"
  user.password_confirmation = "password123"
end

# サンプル質問とAI回答
questions_data = [
  {
    user: user1,
    title: "火災保険の水災補償はどこまでカバーされますか？",
    content: "自宅が床上浸水した場合、火災保険の水災補償で保険金は支払われますか？また、床下浸水の場合はどうでしょうか？",
    answer: "火災保険の水災補償は、一般的に以下の条件で保険金が支払われます。\n\n【補償対象となるケース】\n・床上浸水（地盤面から45cmを超える浸水）\n・建物の損害割合が30%以上の場合\n\n【注意点】\n・床下浸水のみの場合は、多くの保険では補償対象外となります\n・土砂崩れによる損害は水災として補償されるケースが多いです\n・マンションの高層階でも、共用部分の浸水被害は管理組合の保険で対応する場合があります\n\n具体的な補償内容は保険会社や契約内容によって異なりますので、お手元の約款をご確認ください。"
  },
  {
    user: user2,
    title: "自動車保険の等級はどのように引き継がれますか？",
    content: "現在の自動車保険を解約して、別の保険会社に切り替えたいのですが、等級は引き継がれますか？中断証明書とは何ですか？",
    answer: "自動車保険の等級（ノンフリート等級）の引き継ぎについてご説明します。\n\n【等級の引き継ぎ】\n・保険会社を変更しても、等級は引き継がれます\n・満期日から7日以内に新しい契約を開始する必要があります\n・事故有係数適用期間も引き継がれます\n\n【中断証明書について】\n・車を手放すなどの理由で保険を中断する場合に発行される証明書です\n・中断証明書があれば、最大10年間等級を保存できます\n・再度車を取得した際に、中断前の等級で契約を再開できます\n\n【手続きの流れ】\n1. 現在の保険会社に解約（または満期終了）の連絡\n2. 中断証明書の発行を依頼（必要な場合）\n3. 新しい保険会社に等級の引き継ぎを申告\n\n確認が必要です：等級の引き継ぎ条件は保険会社によって細かい違いがある場合がありますので、事前に新旧両方の保険会社にご確認ください。"
  },
  {
    user: user1,
    title: "賠償責任保険と傷害保険の違いを教えてください",
    content: "事業で使う保険を検討しています。賠償責任保険と傷害保険の違いが分かりません。それぞれどのような場合に必要ですか？",
    answer: "賠償責任保険と傷害保険は、保険の目的と補償対象が大きく異なります。\n\n【賠償責任保険】\n・目的：他人に損害を与えた場合の賠償金を補償\n・例：お客様が店舗内で転倒してケガをした場合の治療費・慰謝料\n・種類：施設賠償責任保険、生産物賠償責任保険（PL保険）、専門職業賠償責任保険など\n\n【傷害保険】\n・目的：自分自身や従業員のケガを補償\n・例：業務中に従業員がケガをした場合の治療費・休業補償\n・種類：普通傷害保険、労働災害総合保険など\n\n【事業で必要な場面】\n・対外的なリスク（顧客・第三者への賠償）→ 賠償責任保険\n・内部のリスク（従業員のケガ）→ 傷害保険\n・製品を製造・販売する場合 → PL保険（賠償責任保険の一種）\n\n多くの事業者は両方の保険に加入することをお勧めします。具体的な補償内容や保険料については、保険代理店にご相談ください。"
  }
]

questions_data.each do |data|
  question = Question.find_or_create_by!(title: data[:title]) do |q|
    q.user = data[:user]
    q.content = data[:content]
  end

  AiAnswer.find_or_create_by!(question: question) do |a|
    a.content = data[:answer]
  end
end

puts "Seed data created: #{User.count} users, #{Question.count} questions, #{AiAnswer.count} AI answers"
