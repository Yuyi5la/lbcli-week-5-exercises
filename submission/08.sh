# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

PUBKEY_HASH=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 20)

# 6 months = 6 * 30 * 24 * 3600 = 15,552,000 seconds
# / 512 = 30,375 units = 0x76A7
# Set bit 22 (time flag): 0x76A7 | 0x400000 = 0x4076A7
# Little-endian 3 bytes: A7 76 40
SEQUENCE_LE="a77640"

# Opcodes
OP_CSV="b2"
OP_DROP="75"
OP_DUP="76"
OP_HASH160="a9"
OP_EQUALVERIFY="88"
OP_CHECKSIG="ac"
PUSH20="14"
PUSH3="03"

script="${PUSH3}${SEQUENCE_LE}${OP_CSV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH20}${PUBKEY_HASH}${OP_EQUALVERIFY}${OP_CHECKSIG}"

echo "$script"