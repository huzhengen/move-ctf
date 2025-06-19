module solve_chapter_1::solve{
    use chapter_1::check_in::get_flag;
    use std::string;
    use std::bcs;
    use std::hash::sha3_256;

    // testnet
    // PackageID: 0x6c70276957065426b085f5169dd7b2a9026d40e3ba4739e315130a63eaf0cb31                 │
    public entry fun solve_get_flag(ctx: &mut TxContext){
        let github_id = string::utf8(b"huzhengen");
        let mut bcs_input = bcs::to_bytes(&string::utf8(b"LetsMoveCTF"));
        vector::append<u8>(&mut bcs_input, *github_id.as_bytes());
        let flag_hash = sha3_256(bcs_input);
        get_flag(flag_hash, github_id, ctx);  
    }
}
