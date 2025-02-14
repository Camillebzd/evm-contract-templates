// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const WhitelistERC20Module = buildModule("WhitelistERC20Module", (m) => {
  const owner = m.getAccount(0);
  const whitelistERC20 = m.contract("WhitelistERC20", [owner]);

  return { whitelistERC20 };
});

export default WhitelistERC20Module;
