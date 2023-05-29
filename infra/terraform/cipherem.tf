/*
    This is a usage example of the "SCB-TechX-Saber-Labs/ecs-private-ethereum-blockchain/aws" module version "0.1.0".
    The arguments and outputs might be different in the future versions.
*/

# Call the module and set the local name as "cipherem" to refer to this instance of the module later.
module "cipherem" {
    
    # Required argument 
    # To tell terraform where to download the module's source code when running "terraform init".
    # In this example, the source is terraform's public registry.
    source                  = "SCB-TechX-Saber-Labs/ecs-private-ethereum-blockchain/aws"
    
    # Optional argument
    # To specify the version of the module, otherwise it uses the latest version.
    version                 = "0.1.0"
  
    # Required argument
    # To distinguish this provisioning from others as this is used to name the created AWS components.
    network_name            = "devel"

    # Optional argument
    # How many Ethereum nodes to run in the blockchain network, the default is 2 if not specified.
    number_of_nodes         = 2
    
    # Required argument
    # Specify the AWS region for the provisioned infrastructure.
    region                  = "ap-southeast-1"

    # Required argument
    # The AWS VPC ID for the provisioned infrastructure.
    vpc_id                  = "vpc-062bb1913e6cfe4e8"
  
    # Required argument
    # The list of AWS subnet to place the Ethereum nodes inside.
    subnet_ids              = [
        "subnet-044b115ee3f389342",
        "subnet-0118823ee8ba1c3e2",
        "subnet-0b755989bc27196f1"
    ]

    # Required argument
    # Whether the specified subnets are public subnets or private subnets.
    is_public_subnets       = false

    # Optional argument
    # Specify the mapping of Ethereum address and the amount of ETH for initial allocations.
    # It is convenient to have balance in accounts for testing purpose.
    # The addess with public key and private key can be generated from https://iancoleman.io/bip39/
    # Write down the private key as it is required to access the balance in the account.
    initial_eth_allocations = {
        "0xB5F39800302430c4410ce3F040ac00E1D6cA0CD2": "10",
        "0x66c0874A273b43aB9967C1474360457e2C910949": "5",
    }
    
    # The following are optional arguments for port numbers to exposing services.
    # No need to specify, if there is no change required.
    go_ethereum_p2p_port       = 21000
    go_ethereum_rpc_port       = 22000
    # ethstats_port              = 3000
    # ethereum_explorer_port     = 80

    # The following are optional arguments for the docker images used to run services' container in the module.
    # The default values are the images from docker hub.
    # You might need to modify them to use your own image registry, in case of the docker hub rate limit is reached.
    go_ethereum_docker_image             = "ethereum/client-go:alltools-v1.10.8"
    aws_cli_docker_image                 = "amazon/aws-cli"
    # ethstats_docker_image                = "puppeth/ethstats:latest"
    # ethereum_lite_explorer_docker_image  = "alethio/ethereum-lite-explorer:v1.0.0-beta.10"
}
  
# The Ethereum "chain ID" of the provisioned blockchain network.
output "chain_id" {
     value = module.cipherem.chain_id
}

# The ECS cluster name created for running the services' container.
output "ecs_cluster_name" {
     value = module.cipherem.ecs_cluster_name
}

# The DNS of Network Load Balancer for exposing the services.
output "nlb_dns" {
     value = module.cipherem.nlb_dns
}

# # The HTTP endpoint to access the Ethereum block explorer.
# output "ethereum_explorer_endpoint" {
#      value = module.cipherem.ethereum_explorer_endpoint
# }

# # The HTTP endpoint to access the Ethereum Network Statistics dashboard.
# output "ethstats_endpoint" {
#      value = module.cipherem.ethstats_endpoint
# }

# The HTTP endpoint for Go Ethereum's RPC APIs.
output "geth_rpc_endpoint" {
     value = module.cipherem.geth_rpc_endpoint
}
    
# The overall status output from the module.
output "status" {
    value = module.cipherem._status
}
