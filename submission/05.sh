# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
# Public key
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

# Compute HASH160 (SHA256 → RIPEMD160) of the public key
PUBKEY_HASH=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 20)

# 150 blocks = 0x0096, little-endian = 9600
BLOCKS_LE="9600"

# Opcodes
OP_CSV="b2"
OP_DROP="75"
OP_DUP="76"
OP_HASH160="a9"
PUSH20="14"
OP_EQUALVERIFY="88"
OP_CHECKSIG="ac"
PUSH2="02"

# Script: <150> OP_CSV OP_DROP OP_DUP OP_HASH160 <pubKeyHash> OP_EQUALVERIFY OP_CHECKSIG
script="${PUSH2}${BLOCKS_LE}${OP_CSV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH20}${PUBKEY_HASH}${OP_EQUALVERIFY}${OP_CHECKSIG}"

echo "$script"