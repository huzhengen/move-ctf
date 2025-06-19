module chapter_1::check_in {
    use std::string::{Self, String};
    use std::bcs;
    use std::hash::sha3_256;
    use sui::event;

    // testnet
    // PackageID: 0xd0d9910cb69220eb1a30be78b61e7ca6ddc5fc01569f40dea9415ddc0a6e0ea0                 │
    public struct FlagEvent has copy, drop {
        sender: address,
        flag: String,
        success: bool
    }

    public entry fun get_flag(
        flag: vector<u8>,
        github_id: String,
        ctx: &mut TxContext
    ) {
        let mut bcs_input = bcs::to_bytes(&string::utf8(b"LetsMoveCTF"));
        vector::append<u8>(&mut bcs_input, *github_id.as_bytes());
        let expected_hash = sha3_256(bcs_input);

        if (flag == expected_hash) {
            event::emit(FlagEvent {
                sender: tx_context::sender(ctx),
                flag: string::utf8(b"CTF{WelcomeToMoveCTF}"),
                success: true
            });
        } else {
            event::emit(FlagEvent {
                sender: tx_context::sender(ctx),
                flag: string::utf8(b"Try again!"),
                success: false
            });
        }
    }
}
