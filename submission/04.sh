# Create a CLTV script with a timestamp of 1495584032 and public key below:
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

#<locktime> OP_CHECKLOCKTIMEVERIFY OP_DROP OP_DUP OP_HASH160 <pubKeyHash> OP_EQUALVERIFY OP_CHECKSIG
locktime=1495584032
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

PUBKEY_HASH=$(echo -n "$publicKey"| xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 -binary | xxd -p -c 200)

hex=$(printf '%08x' $locktime)
little_endian=$(echo $hex | sed -E 's/(..)(..)(..)(..)/\4\3\2\1/')

#variables
OP_CLTV=b1
OP_DROP=75
OP_DUP=76
OP_HASH160=a9
OP_EQUALVERIFY=88
OP_CHECKSIG=ac
PUSH20=14

script="04${little_endian}${OP_CLTV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH20}${pubkeyhash}${OP_EQUALVERIFY}${OP_CHECKSIG}"
echo $script