import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";
import "@nomicfoundation/hardhat-ethers";
import "@nomicfoundation/hardhat-verify"

const PRIVATE_KEY =
  process.env.PRIVATE_KEY ||
  "";

// Etherlink testnet
const ETHERLINK_TESTNET_RPC_URL =
  process.env.ETHERLINK_TESTNET_RPC_URL ||
  "https://node.ghostnet.etherlink.com";
const ETHERLINK_TESTNET_API_KEY =
  process.env.ETHERLINK_TESTNET_API_KEY ||
  "YOUCANCOPYME0000000000000000000000";

// Etherlink
const ETHERLINK_RPC_URL =
  process.env.ETHERLINK_RPC_URL ||
  "https://node.mainnet.etherlink.com";
const ETHERLINK_API_KEY =
  process.env.ETHERLINK_API_KEY ||
  "YOUCANCOPYME0000000000000000000000";

const config: HardhatUserConfig = {
  solidity: "0.8.22",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
      chainId: 31337
    },
    
    etherlinkTestnet: {
      chainId: 128123,
      url: ETHERLINK_TESTNET_RPC_URL,
      accounts: [PRIVATE_KEY],
    },
    etherlink: {
      chainId: 42793,
      url: ETHERLINK_RPC_URL,
      accounts: [PRIVATE_KEY],
    },
    
  },
  etherscan: {
    apiKey: {
      etherlinkTestnet: ETHERLINK_TESTNET_API_KEY,
      etherlink: ETHERLINK_API_KEY,
    },
    customChains: [
      {
        network: "etherlinkTestnet",
        chainId: 128123,
        urls: {
          apiURL: "https://testnet.explorer.etherlink.com/api",
          browserURL: "https://testnet.explorer.etherlink.com"
        }
      },
      {
        network: "etherlink",
        chainId: 42793,
        urls: {
          apiURL: "https://explorer.etherlink.com/api",
          browserURL: "https://explorer.etherlink.com"
        }
      }
    ]
  }
};

export default config;
