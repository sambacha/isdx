## [isdx](#)
> Introspection / Observability smart contracts 

### examples

- `AllowancesHelper`

```solidity
 // Fetch allowances
        Allowance[] memory _allowances = new Allowance[](numberOfAllowances);
        uint256 allowanceIdx;
        for (tokenIdx = 0; tokenIdx < tokensAddresses.length; tokenIdx++) {
            for (spenderIdx = 0; spenderIdx < spenderAddresses.length; spenderIdx++) {
                address spenderAddress = spenderAddresses[spenderIdx];
                address tokenAddress = tokensAddresses[tokenIdx];
                IERC20 token = IERC20(tokenAddress);
                uint256 amount = token.allowance(ownerAddress, spenderAddress);
                if (amount > 0) {
                    Allowance memory allowance = Allowance({
                        owner: ownerAddress,
                        spender: spenderAddress,
                        amount: amount,
                        token: tokenAddress
                    });
                    _allowances[allowanceIdx] = allowance;
                    allowanceIdx++;
                }
            }
        }
        return _allowances;
```
