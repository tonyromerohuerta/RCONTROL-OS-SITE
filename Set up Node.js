- name: Set up Node.js
         uses: actions/setup-node@v3
         with:
           node-version: 16

       # Step 3: Install dependencies
       - name: Install dependencies
         run: npm install

       # Step 4: Deploy the contract
       - name: Deploy Smart Contract
         env:
           PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
           INFURA_API_KEY: ${{ secrets.INFURA_API_KEY }}
         run: |
           npx hardhat run scripts/deploy.js --network mainnet