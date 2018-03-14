/*
Implements EIP20 token standard: https://github.com/ethereum/EIPs/issues/20
.*/


pragma solidity ^0.4.18;

import "./EIP20Interface.sol";


contract UCASH is EIP20Interface {

    uint256 constant MAX_UINT256 = 2**256 - 1;


    string public name;
    uint8 public decimals;
    string public symbol;

     function UCASH(

        ) public {
        totalSupply = 21*10**9*10**8;               //UCASH totalSupply
        balances[msg.sender] = totalSupply;         //Allocate UCASH to contract deployer
        name = "UCASH";
        decimals = 8;                               //Amount of decimals for display purposes
        symbol = "UCASH";
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) view public returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
    view public returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
}
