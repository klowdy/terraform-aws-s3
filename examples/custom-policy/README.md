# Custom Policy

If you supply your own policy. you need to be aware of the following:

- If your policy grants public access to the bucket you must make sure the public access blocks are off and the acls are set to `public-read`
- If `grant_owner_access` is set to `true`, the supplied policy document will be merged with the policy provided as part of this module
