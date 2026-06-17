# kintai（勤怠管理アプリ）

大田原工業 工事部のQRコード打刻式 勤怠管理Webアプリ。作業員ごとのQRコードをカメラで読み取り、出退勤・休憩・残業を記録、日別/月次でCSV出力する。

## 構成
- **単一HTMLアプリ**。編集対象は `index.html` 1ファイルのみ
- その他: `manifest.json`, `icon.svg`, `privacy.html`, `serve.ps1`, `start.bat`, `start-network.bat`, `.gitignore`
- フレームワーク・ビルド工程なし（バニラJS + localStorage + Dropbox API + jsQR + qrcode-generator CDN）

## 起動・公開
- ローカル起動: `start.bat` ダブルクリック → http://localhost:8091/
- 公開URL: https://takahiro-koizumi.github.io/kintai/
- デプロイ: `main` branch に push → GitHub Pages が自動公開（CLI push可：GCM経由）
- リポジトリ: https://github.com/takahiro-koizumi/kintai （Public）
- **カメラ使用はhttps必須**。ローカルhttpでも動くがカメラ動作確認は公開URLで行うこと

## Dropbox連携
- App Key: `w0akss3w157oa53`（Full Dropbox型、genba-board/kouteihyoと共有）
- 保存先パス: `/★大田原工業　工事部/事務/勤怠管理/kintai.json`
- 保存済みパスが `/★大田原工業　工事部/` で始まらなければ既定へ自動移行（旧フォルダ名・旧 `☆施工中/★勤怠管理/` パスを一括で吸収。旧 `LEGACY_DBX_PATHS` を置換）
- localStorageキー（状態）: `kintai_state`
- localStorageキー（保存パス）: `kintai_dbx_file_path`（genba-board/kouteihyoと同一github.ioオリジンを共有するため、必ず `kintai_` 接頭辞を維持すること）
- tokenは3アプリ共有のため、配置ボード等で接続済みなら勤怠アプリも自動接続

## 勤怠ルール（v2、settings配下）
- `workStart`（既定07:30）/ `workEnd`（既定17:00）
- `overtimeStart`（既定17:30）... 残業判定開始時刻
- `overtimeRoundMin`（既定30）... 残業合計の支払単位（floor、0で無効）
- `includeEarlyAsOvertime`（既定true）... 早出を残業に含める
- `weekendAsHoliday`（既定true）... 土日auto休日
- `useCompanyCalendar`（既定true）... 国民祝日＋会社指定休を自動で休日扱い
- `cutoffDay`（既定20）... 月次集計の締め日。「y年m月分」= 前月(c+1)日〜当月c日。31でカレンダー月（月末締め）
- 休日は残業を計上せず全時間を休日労働扱い

## QRコード打刻
- 各作業員にQR（データ形式 `KNT1:<作業員ID>`）。アプリ内でQR表示・カード印刷可
- 打刻画面でカメラ起動→QR読取。開いた記録があれば退勤、なければ出勤
- 同一作業員は打刻後60秒は再打刻不可
- カメラ不可時は名前タップで手動打刻

## 編集ルール
- 修正は `index.html` を直接編集（正本はGitHubフォルダ側）
- 区切りごとに git commit（小さくコミット）
- 動作確認は `start.bat` でローカル起動してから push、カメラ系は公開URLで実機確認
- Dropboxバックアップ: `Dropbox/★大田原工業　工事部/事務/勤怠管理/` に手動コピーで保管（正本ではない）

## 関連アプリ
- [genba-board](https://github.com/takahiro-koizumi/genba-board) ... 現場配置ボード。同じApp Key・同じgithub.ioオリジン
- [kouteihyo](https://github.com/takahiro-koizumi/kouteihyo) ... 工程表アプリ。同じApp Key・同じgithub.ioオリジン

## 詳細メモ
ユーザーのauto-memory `project_kintai.md` に公開作業の経緯、CLI push設定、作業員マスタ生成手順の詳細あり。
