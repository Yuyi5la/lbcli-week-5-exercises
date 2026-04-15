# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277


# Public key
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277


PUBKEY_HASH=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 20)

# 150 blocks = 0x0096 (little endian)
BLOCKS="0096"

# OP codes
OP_CSV="b2"
OP_DROP="75"
OP_DUP="76"
OP_HASH160="a9"
PUSH20="14"
OP_EQUALVERIFY="88"
OP_CHECKSIG="ac"

# Final script:
# <150> OP_CSV OP_DROP OP_DUP OP_HASH160 <pubKeyHash> OP_EQUALVERIFY OP_CHECKSIG
script="0200${BLOCKS}${OP_CSV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH20}${PUBKEY_HASH}${OP_EQUALVERIFY}${OP_CHECKSIG}"

echo "$script"