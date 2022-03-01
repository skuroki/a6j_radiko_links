Twitterにラジオ番組のradikoのリンクをつぶやくだけのbotプログラムです。

コンテナの設定とかするのが怠く感じたので、rubyのバージョンが最新ではないことを妥協しつつ、Google Cloud Functionsを使ってみました。

## デプロイ

```
gcloud functions deploy tweet_links --project PROJECT_NAME --trigger-topic TOPIC_NAME --runtime ruby27
```

- rubyファイルの名前はapp.rbである必要がありました。（どこかで変えられるかも、未確認）
- `tweet_links` はapp.rb内で記述した名前と同じである必要がありました。

## 定期実行

TOPIC_NAMEのpubsubが設定されるので、Google Cloud Schedulerからcron形式でそのpubsubを実行するように設定すればできます。
