variable region {}

provider "aws" {
    region = var.region
    access_key = "[ACCESS_KEY]"
    secret_key = "[ACCESS_SECRET]"
}