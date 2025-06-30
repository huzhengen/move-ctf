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