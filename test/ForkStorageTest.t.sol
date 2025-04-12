pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdChains} from "forge-std/StdChains.sol";

contract CounterTest is Test {
    struct Domain {
        StdChains.Chain chain;
        uint256 forkId;
    }

    struct Bridge {
        Domain source;
        Domain destination;
        uint256 someVal;
    }

    struct SomeStruct {
        Domain domain;
        Bridge[] bridges;
    }

    mapping(uint256 => SomeStruct) internal data;

    function setUp() public {
        StdChains.Chain memory chain1 = getChain("mainnet");
        StdChains.Chain memory chain2 = getChain("base");
        Domain memory domain1 = Domain(chain1, vm.createFork(chain1.rpcUrl, 22253716));
        Domain memory domain2 = Domain(chain2, vm.createFork(chain2.rpcUrl, 28839981));
        data[1].domain = domain1;
        data[2].domain = domain2;

        vm.selectFork(domain1.forkId);

        data[2].bridges.push(Bridge(domain1, domain2, 123));
        vm.selectFork(data[2].domain.forkId);
        vm.selectFork(data[1].domain.forkId);
        data[2].bridges.push(Bridge(domain1, domain2, 456));

        assertEq(data[2].bridges.length, 2);
    }

    function test_storage() public {
        // UNCOMMENT THIS TO FIX THE ASSERT BELOW
        // Why does this work?
        //assertEq(data[2].bridges.length, 2);

        vm.selectFork(data[2].domain.forkId);

        assertEq(data[2].bridges.length, 2);
    }
}
