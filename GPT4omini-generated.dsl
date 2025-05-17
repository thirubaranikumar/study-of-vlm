workspace {

  model {
    user = person "Monitoring User" {
      description "User who monitors the system via dashboards"
    }

    system = softwareSystem "Data Processing Platform" {
      description "Platform handling modular monolith applications, data streaming, monitoring, and analytics."

      apiServer = container "API Server" {
        technology "REST"
        description "Receives API requests from external clients"
      }

      cache = container "Cache Component" {
        technology "In-memory Cache"
        description "Caching layer used by the API Server"
      }

      monolith = container "Modular Monolith" {
        technology "Java / Spring Boot"
        description "Monolith with internal modular structure"
        tags "Monolith"
      }

      dbGateway = container "Database Gateway" {
        technology "Multi-Tenant Proxy"
        description "Gateway for routing database queries with tenancy support"
      }

      dbServers = container "Database Servers" {
        technology "RDBMS"
        description "Underlying physical databases with multi-tenancy support"
        tags "Database"
      }

      kms = container "Key Management Server" {
        technology "HashiCorp Vault"
        description "Used for secure secret and key management"
      }

      cdcConnectors = container "CDC Connectors" {
        technology "Debezium"
        description "Captures change data from databases"
      }

      kafka = container "Kafka Clusters" {
        technology "Apache Kafka"
        description "Handles event streaming and communication"
      }

      kafkaConsumers = container "Kafka Consumers" {
        technology "Custom/ETL Services"
        description "Consumes Kafka topics and forwards data"
      }

      elasticStack = container "Elastic Stack" {
        technology "ELK (ElasticSearch, Logstash, Kibana)"
        description "Used for logging, monitoring, and visualization"
      }

      graphDb = container "Graph Database" {
        technology "Neo4j / Similar"
        description "Target data sink for complex relationships"
        tags "Database"
      }

      dataWarehouse = container "Data Warehouse" {
        technology "Snowflake / Redshift / Similar"
        description "Stores structured data for analytics"
        tags "Database"
      }

      dataMarts = container "Data Marts" {
        technology "OLAP"
        description "Downstream analytical data marts"
        tags "Database"
      }

      // Relationships
      apiServer -> cache "Uses"
      apiServer -> monolith "Routes API calls to backends"
      monolith -> dbGateway "Reads/Writes data via"
      monolith -> kms "Uses for secrets and key retrieval"
      dbGateway -> dbServers "Forwards DB queries"
      dbServers -> cdcConnectors "Change Data Capture (CDC)"
      cdcConnectors -> kafka "Pushes change events"
      kafka -> kafkaConsumers "Streams data to consumers"
      kafkaConsumers -> graphDb "Saves graph data"
      kafkaConsumers -> dataWarehouse "Loads warehouse data"
      kafkaConsumers -> dataMarts "Loads data marts"
      dbServers -> elasticStack "Push via FileBeats"
      kafka -> elasticStack "Push via FileBeats"
      cdcConnectors -> elasticStack "Push via FileBeats"
      elasticStack -> user "Dashboard/Monitoring access"
    }
  }

  views {
    systemContext system {
      include *
      autolayout lr
    }

    container system {
      include *
      autolayout lr
    }

    styles {
      element "Database" {
        shape cylinder
        background #f9f9c5
      }

      element "Monolith" {
        shape roundedbox
        background #d0f0c0
        color #000000
      }

      element "Kafka" {
        shape hexagon
        background #ffc0cb
      }

      element "Elastic Stack" {
        shape roundedbox
        background #f5f5dc
      }
    }

    theme default
  }
}
