# AWSS3 & AWS Cognito

Fiddling with AWS S3 Websites leveraging AWS Cognito for authentication

Terraform is based on the tutorial https://transcend.io/blog/restrict-access-to-internal-websites-with-beyondcorp/ and the public repository: https://github.com/transcend-io/beyondcorp-cloudfront

## Notes

- This approach isn't really something I think is great
- The lack of ease configuration for Lambdas, and the need to either embed configuration in the lambda zip, or through AWS SSM is not ideal
- Either a single monolith terraform module, or split between multiple. Adds a lot of overhead which is less than ideal
- AWS S3 just doesn't feel like a good source for storing the S3 artifacts - requires bucket policy + "public" - Don't like
- Seems more preferable to have something like K8s + Nginx pod - Management of secrets/dns/etc can be externalized then
- Docker images gives the opportunity to sign with something like cosign, ability to "extend" with URL rewrites/etc through nginx itself
- Authentication can be fronted as part of existing K8s services used by backends
- Entire system can be validated with a local installation of K8s
- Alternative caching layers seem more ideal (e.g. Cloudflare pages / etc), thing that can go infront of the primary service
- Could a k8s-ingress served entity just synchronize with other CDNs?
- Cloudfront "deploying" wait times are kind of in the way for rapid changes (exists in k8s with pods, but cloudfront just _feels_ slower?)

Overall not really liking this approach, as it doesn't simplify the system as much as I was hoping it would.
