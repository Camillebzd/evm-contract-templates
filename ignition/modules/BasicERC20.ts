// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const BasicERC20Module = buildModule("BasicERC20Module", (m) => {
  const owner = m.getAccount(0);
  const basicERC20 = m.contract("BasicERC20", [owner]);

  return { basicERC20 };
});

export default BasicERC20Module;
