#!/bin/bash
rustup target add wasm32-unknown-unknown
cargo install pwasm-utils-cli --bin wasm-build --version 0.6.0

cargo build --examples --target wasm32-unknown-unknown --release --features std

cargo build --release --target wasm32-unknown-unknown --no-default-features --features "panic_with_msg"
pushd cap9-kernel
cargo build --release --target wasm32-unknown-unknown --no-default-features --features "panic_with_msg"
popd
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/cap9_kernel.wasm ./target/wasm32-unknown-unknown/release/cap9_kernel.wasm
wasm-build --target=wasm32-unknown-unknown ./target cap9-kernel

# Copy Examples
cp ./target/wasm32-unknown-unknown/release/examples/*.wasm ./target/wasm32-unknown-unknown/release

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/writer_test.wasm ./target/wasm32-unknown-unknown/release/writer_test.wasm
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/writer_test.wasm ./target/wasm32-unknown-unknown/release/writer_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target writer_test

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/entry_test.wasm ./target/wasm32-unknown-unknown/release/entry_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target entry_test

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/caller_test.wasm ./target/wasm32-unknown-unknown/release/caller_test.wasm
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/caller_test.wasm ./target/wasm32-unknown-unknown/release/caller_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target caller_test

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/logger_test.wasm ./target/wasm32-unknown-unknown/release/logger_test.wasm
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/logger_test.wasm ./target/wasm32-unknown-unknown/release/logger_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target logger_test

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/register_test.wasm ./target/wasm32-unknown-unknown/release/register_test.wasm
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/register_test.wasm ./target/wasm32-unknown-unknown/release/register_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target register_test

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/delete_test.wasm ./target/wasm32-unknown-unknown/release/delete_test.wasm
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/delete_test.wasm ./target/wasm32-unknown-unknown/release/delete_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target delete_test

cargo run --package cap9-build -- build-proc ./target/wasm32-unknown-unknown/release/account_call_test.wasm ./target/wasm32-unknown-unknown/release/account_call_test.wasm
cargo run --package cap9-build -- set-mem --pages 4 ./target/wasm32-unknown-unknown/release/account_call_test.wasm ./target/wasm32-unknown-unknown/release/account_call_test.wasm
wasm-build --target=wasm32-unknown-unknown ./target account_call_test

wasm-build --target=wasm32-unknown-unknown ./target external_contract
