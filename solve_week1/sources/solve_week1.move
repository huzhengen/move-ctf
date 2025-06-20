module solve_week1::solve;

use std::bcs;
use std::hash::sha3_256;
use std::string::{Self, String};
use std::vector;
use sui::random::Random;
use sui::tx_context::TxContext;
use week1::challenge::{Self, Challenge};

// https://learnblockchain.cn/article/17064
// PackageID: 0xc8f1ca75340cf59f1bf99944ab3077c533715d323aaec44ab54ad67dbf5e4608
// Transaction Digest: 2QpnXpwyh9nzinNjBcSyPtAS3K7vHnfqrqWpTuxaE95h
public entry fun solve_get_flag(challenge: &mut Challenge, rand: &Random, ctx: &mut TxContext) {
    //seed
    let seed = 34; // length of "Letsmovectf_week1" is 17, so 17 * 2 = 34

    //score
    let secret = b"Letsmovectf_week1";
    let secret_hash = sha3_256(secret);
    let score = (
        ((*vector::borrow(&secret_hash, 0) as u64) << 24) |
        ((*vector::borrow(&secret_hash, 1) as u64) << 16) |
        ((*vector::borrow(&secret_hash, 2) as u64) << 8) |
        (*vector::borrow(&secret_hash, 3) as u64),
    );

    //github_id
    let github_id = string::utf8(b"4c752bbd-9712-452f-aa8b-f5e7dcef217d");

    //hash_input
    let mut bcs_input = bcs::to_bytes(&string::utf8(secret));
    vector::append(&mut bcs_input, *string::bytes(&github_id));
    let hash_input = sha3_256(bcs_input);

    //magic_number
    let magic_number = score % 1000 + seed;

    //guess
    let guess = b"83419";

    challenge::get_flag(
        score,
        guess,
        hash_input,
        github_id,
        magic_number,
        seed,
        challenge,
        rand,
        ctx,
    );
}
