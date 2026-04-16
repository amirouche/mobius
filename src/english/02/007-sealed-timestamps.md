## 27. Sealed Timestamps

Content may be committed and timestamped without disclosure. A combiner's hash is computed from its de Bruijn tree and stored locally. `bb anchor` requests an OpenTimestamps proof — a Bitcoin-anchored timestamp that makes priority cryptographic, not just local. The content stays in the local store. Nobody sees it. Content only leaves when explicitly pushed via `bb remote push` or `bb remote sync`.

The priority proof and the content disclosure are separate acts. The sealed envelope, made mathematical. If the author ever needs to prove they made it first, they reveal the content and the hash matches what the timestamp already proved.

A store that accommodates sealed hashes accumulates **dark matter** — timestamps that anchor facts nobody can see. This is not a bug. It is a structural feature. The realistic population of knowledge workers includes people who need priority proof without disclosure: industrial researchers, solo inventors, small teams in competitive fields. Omitting them maps a fantasy commons, not a real one.

