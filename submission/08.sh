# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

PUBKEY_HASH=$(echo -n "$publicKey" \
| xxd -r -p \
| openssl dgst -sha256 -binary \
| openssl dgst -rmd160 -binary \
| xxd -p -c 200)

# 6 months = 15552000 seconds
# /512 = 30375 = 0x76A7
SEQUENCE_HEX="76a7"
SEQUENCE_LE="a776"   # little endian

# OP codes
OP_CSV="b2"
OP_DROP="75"
OP_DUP="76"
OP_HASH160="a9"
OP_EQUALVERIFY="88"
OP_CHECKSIG="ac"
PUSH20="14"

script="03${SEQUENCE_LE}${OP_CSV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH20}${PUBKEY_HASH}${OP_EQUALVERIFY}${OP_CHECKSIG}"

echo "$script"