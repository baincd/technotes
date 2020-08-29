_NOTE: These are just some personal notes solely intended as a convenience, and there is absolutely positively no guarantee of the accuracy, correctness, or currentness of the information provided.  Use at your own risk!!_

# Symmetric Cryptography

Same key used for encryption and decryption

- Stream Ciphers (Bit-by-bit encryption, key is one time use and must be at least as long as plain text): not widely used
- Block Ciphers
  - AES (Advanced Encryption System): recommended
  - 3DES (Triple-DES): still in use, but should be avoided
  - DES, RC4, RC2: broken - do not use
  - Also requires an Encryption Mode
    - GCM (Galois/Counter Mode): Widely supported, protects confidentiality and integrity (uses a counter and IV (Initialization Vector))
    - CBC (Cipher Block Chaining): Most common (XOR each block with previous block, uses IV for first block)
      - Requires padding - commonly PKCS5 of PKCS7 (adds bytes representing padding length, ex: 04 04 04 04)
    - Also need to consider [key size](https://keylength.com)
      - 128-bit is usually sufficient
      - 256-bit for sensitive data

# Asymmetric (Public/Private Key) Cryptography

Provides confidentiality and authenticity, but much slower than symmetric cryptography due to key size

- RSA: Well known, mature, widely used (rec [key size](https://keylength.com): 2048-bit)
- ElGamal: Slightly faster and more effecient
- elliptic curve: smaller keys provide same level of security (rec key size: 384-bit)
- padding:
  - OAEP (Optimal Asymmetric Encryption Padding): preferred
  - PKCS1 v1.5: vulnerable to chosen-ciphertext attack

Revoking certificates:
- CRLs (Certificate Revokation Lists): revoked certificates periodically published by CA
- OCSP (Online Certificate Status Protocol): direct query to CA to get realtime revocation status of a certificate

Certificate Pinning: certificate pre-loaded in application.  New certificates distributed through application update channels

# Hashing (One-way)

- Use SHA-2 (SHA-224, SHA-256, SHA-384, SHA-512) or SHA-3 (SHA3-224, SHA3-256, SHA3-384, SHA3-512)
- SHA-1 is nearing end-of-life
- MD5 is insecure

Uses:
* Checksum
* MAC (Message Authentication Code): Hash function with a shared secret key (provides data origin authentication and integrity)
  - HMAC: most widely used.  Can be constructed from any hash function (ex: HMAC-SHA512), uses 2 keys and does 2 hash computations.  Security depends on hash function used.
  - CMAC, OMAC: preferred variations on CBC-MAC
  - CBC-MAC: vulnerable to several attacks, should be avoided
  - For integrity and confidentiality: encrypt message first, then compute MAC
* Digital Signature (provides data origin authentication, integrity)
  - generate: `sig = encrypt(hash(msg),privateKey)`
  - validate: `decrypt(sig, publicKey) == hash(msg)`
  - Options:
    - RSA-based
    - DSA (Digital Signature Algorithm)
    - ECDSA (Elliptic Curve Digital Signature Algorithm)
    - ElGamal

# SSL/TLS

Use asymmetric key to exchange a authenticate server and exchange a symmetric key, then use symmetric key

SSL 1.0, 2.0, 3.0 and TLS 1.0 are broken - do not use

1. Browser sends TLS version to use and preferred cipher suites and compression methods
2. Server picks cipher suite and compression method
3. Server response includes server certificate
4. Browser verifies certificate
5. Browser generates one-time session private key
6. Browser sends one-time session key encrypted with server's public key
6. Server decrypts session key with server's private key
7. MAC key derived from session key.
8. Further communication done using symmetric encryption using session and MAC key

DHE (Ephemeral Diffie-Hellman) and ECDHE (Ephemeral Elliptic Curve Diffie Hellman) provide forward secrecy (prevents eavesdropping events even if private key compromised)

# Certificates (X.509)

Contents include:
- Subject
- validity date range
- cert version
- extension (v3 certs)
- Public Key
- Issuing CA
- Digitally signature by issuing CA

[X.509 Certificate reference](https://www.ssl.com/faqs/what-is-an-x-509-certificate/)

File Formats:
- DER = binary DER encoded certificate [Distinguished Encoding Rules]
- PEM = Base 64 (uses -----BEGIN CERTIFICATE-----).  Can also contain the complete certificate chain
- .crt = certificate encoded as DER or PEM (\*nix convention)
- .cer = certificate encoded as DER or PEM (Windows convention)

[Certificate formats reference](https://support.ssl.com/Knowledgebase/Article/View/19/0/der-vs-crt-vs-cer-vs-pem-certificates-and-how-to-convert-them)

# Additional Considerations and Resources

Compress before encrypting (encrypted data does not compress well)

Consider the Key Length: https://keylength.com

[NIST Cryptographic Standards and Guidelines](https://csrc.nist.gov/projects/cryptographic-standards-and-guidelines)


# Glossary
ASN.1 = document format used by X.509 certificates [Abstract Syntax Notation]

CA = Certificate Authority

DN = Distinguished Name

PKCS = Public Key Crypto Standard

PKI = Public Key Infrastructure

PKIX = Public Key Infrastructure (X.509)
