# Decentralized Energy Grid Management System

## Overview

This decentralized energy grid management system leverages blockchain technology to create a transparent, efficient, and secure platform for peer-to-peer energy trading. The system enables direct transactions between energy producers and consumers while providing robust verification, tracking, and settlement mechanisms.

## Core Components

The system consists of five key smart contracts that work together to form a comprehensive energy management ecosystem:

### 1. Producer Verification Contract

This contract validates and manages energy generators in the network.

- **Producer Registration**: Onboards new energy producers with verified credentials
- **Equipment Certification**: Records and verifies generation equipment specifications
- **Compliance Tracking**: Ensures producers maintain regulatory standards
- **Reputation System**: Tracks producer reliability and quality metrics

### 2. Consumer Identity Contract

This contract manages user profiles and authentication for energy consumers.

- **User Registration**: Securely registers consumer identities
- **Consumption Profiling**: Records usage patterns and preferences
- **Access Control**: Manages permissions for different user types
- **Privacy Protection**: Implements data protection measures for sensitive user information

### 3. Production Tracking Contract

This contract maintains a verifiable record of energy generation.

- **Real-time Monitoring**: Captures energy production data from IoT devices
- **Generation Certification**: Issues and verifies renewable energy certificates
- **Forecasting Support**: Provides data for production predictions
- **Audit Trail**: Maintains immutable records for compliance purposes

### 4. Distribution Contract

This contract handles the allocation of energy resources throughout the network.

- **Supply-Demand Matching**: Pairs producers with consumers based on availability and needs
- **Grid Balancing**: Optimizes energy distribution to maintain system stability
- **Congestion Management**: Prevents bottlenecks in energy transmission
- **Smart Grid Integration**: Interfaces with traditional grid infrastructure

### 5. Payment Settlement Contract

This contract automates the financial aspects of energy trading.

- **Micropayment Processing**: Handles small-scale, frequent transactions efficiently
- **Dynamic Pricing**: Adjusts rates based on real-time supply and demand
- **Multi-currency Support**: Accommodates various payment methods including cryptocurrencies
- **Escrow Services**: Secures funds until delivery conditions are met

## Technical Architecture

```
┌───────────────────────────────────────────────────────────────┐
│                       User Interface Layer                     │
│   (Web Application, Mobile App, Administrative Dashboard)      │
└───────────────────┬───────────────────────────┬───────────────┘
                    │                           │
┌───────────────────▼───────────────┐ ┌─────────▼───────────────┐
│      Blockchain Interface Layer    │ │    External Systems     │
│  (Smart Contract API, Event Hooks) │ │   (IoT Devices, Grid)   │
└───────────────────┬───────────────┘ └─────────────────────────┘
                    │
┌───────────────────▼───────────────────────────────────────────┐
│                     Smart Contract Layer                       │
├───────────────┬───────────────┬────────────────┬──────────────┤
│   Producer    │   Consumer    │   Production   │ Distribution  │
│ Verification  │   Identity    │   Tracking     │               │
├───────────────┴───────────────┴────────────────┼──────────────┤
│                Payment Settlement              │              │
└───────────────────────────────────────────────────────────────┘
```

## Getting Started

### Prerequisites

- Ethereum development environment (Truffle/Hardhat)
- Node.js (v14+)
- Web3.js or ethers.js
- MetaMask or similar Ethereum wallet
- Access to Ethereum testnet or local blockchain

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/decentralized-energy-grid.git
   cd decentralized-energy-grid
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Compile smart contracts:
   ```
   npx hardhat compile
   ```

4. Deploy to testnet:
   ```
   npx hardhat run scripts/deploy.js --network rinkeby
   ```

### Configuration

1. Create a `.env` file with your configuration parameters:
   ```
   NETWORK_URL=https://rinkeby.infura.io/v3/YOUR_INFURA_KEY
   PRIVATE_KEY=your_private_key
   ADMIN_ADDRESS=your_admin_wallet_address
   ```

2. Configure the system parameters in `config.js`:
   ```javascript
   module.exports = {
     minimumStake: "1000000000000000000", // 1 ETH
     verificationPeriod: 86400, // 24 hours in seconds
     settlementWindow: 3600, // 1 hour in seconds
     networkFeePercentage: 1 // 1%
   };
   ```

## Usage

### For Producers

1. Register as an energy producer:
   ```javascript
   await producerVerificationContract.registerProducer(
     "Solar Farm ABC",
     "solarpanels_certification_hash",
     { capacity: "500kW", location: "44.5N,104.3W" }
   );
   ```

2. Record energy production:
   ```javascript
   await productionTrackingContract.recordProduction(
     producerId,
     energyAmount,
     timestamp,
     metadataHash
   );
   ```

### For Consumers

1. Register as an energy consumer:
   ```javascript
   await consumerIdentityContract.registerConsumer(
     "Consumer Name",
     "consumer_verification_hash",
     { maxConsumption: "100kW", location: "44.6N,104.2W" }
   );
   ```

2. Request energy allocation:
   ```javascript
   await distributionContract.requestEnergy(
     consumerId,
     requestedAmount,
     maxPrice,
     timeframe
   );
   ```

### For Grid Operators

1. Monitor grid status:
   ```javascript
   const gridStatus = await distributionContract.getGridStatus();
   console.log(`Current load: ${gridStatus.currentLoad}kW`);
   console.log(`Available capacity: ${gridStatus.availableCapacity}kW`);
   ```

2. Handle settlement periods:
   ```javascript
   await paymentSettlementContract.initiateSettlementPeriod(periodId);
   ```

## Testing

Run the test suite:
```
npx hardhat test
```

Run specific test files:
```
npx hardhat test test/ProducerVerification.test.js
```

## Security Considerations

- **Access Control**: Implement proper role-based access control for administrative functions
- **Oracle Security**: Ensure reliable and secure data feeds for external pricing and grid data
- **Smart Contract Audits**: Regular security audits of all smart contracts
- **Privacy Protection**: Compliance with data protection regulations
- **Emergency Procedures**: Implement circuit breakers and emergency shutdown mechanisms

## Roadmap

- **Phase 1**: Core contract deployment and basic functionality
- **Phase 2**: Integration with IoT devices and smart meters
- **Phase 3**: Implementation of AI-based predictive algorithms for demand forecasting
- **Phase 4**: Cross-chain interoperability for multi-region support
- **Phase 5**: Carbon credit integration and sustainability incentives

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add some amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Project Link: [https://github.com/yourusername/decentralized-energy-grid](https://github.com/yourusername/decentralized-energy-grid)

## Acknowledgments

- Ethereum Foundation
- Energy Web Foundation
- Grid+ Energy
- Power Ledger
