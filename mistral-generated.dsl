workspace {

  model {
    user = person "User" {
      description "A user of the system"
    }

    elasticStack = softwareSystem "Elastic Stack" {
      description "ElasticSearch, Kibana, LogStash, and Beats"
    }

    kafkaClusters = softwareSystem "Kafka Clusters" {
      description "Kafka Clusters"
    }

    keyManagementServer = softwareSystem "Key Management Server" {
      description "Hashicorp Vault"
    }

    system = softwareSystem "Inventory System" {
      description "Handles inventory tracking"

      apiServer = container "Api Server" {
        technology "Api Server"
        description "Handles API requests"
      }

      cacheComponent = component apiServer "Cache Component" {
        technology "Cache"
        description "Caches data"
      }

      backend = container "Backend" {
        technology "Modular Monolith Design"
        description "Backend services"
      }

      databaseGateway = container "Database Gateway" {
        technology "Multi-Tenant"
        description "Gateway for database access"
      }

      databaseServers = container "Database Server(s)" {
        technology "Multi-Tenancy Support"
        description "Database servers"
        tags "Database"
      }

      cdc = container "Change Data Capture" {
        technology "CDC"
        description "Captures data changes"
      }

      debezium = container "Debezium" {
        technology "Debezium"
        description "CDC tool"
      }

      kafkaConnectors = container "Kafka Connectors" {
        technology "Kafka Connectors"
        description "Connects Kafka with other systems"
      }

      kafkaConsumers = container "Kafka Consumers" {
        technology "Kafka Consumers"
        description "Consumes messages from Kafka"
      }

      graphDB = container "Graph DB" {
        technology "Graph DB"
        description "Graph database"
        tags "Database"
      }

      dataWarehouses = container "Data Warehouses" {
        technology "Data Warehouses"
        description "Data warehouses"
        tags "Database"
      }

      dataMarts = container "Data Marts" {
        technology "Data Marts"
        description "Data marts"
        tags "Database"
      }

      user -> elasticStack "Uses"
      apiServer -> cacheComponent "Uses"
      apiServer -> backend "Calls"
      backend -> databaseGateway "Calls"
      databaseGateway -> databaseServers "Accesses"
      databaseServers -> cdc "Push via FileBeats"
      cdc -> debezium "Interacts"
      debezium -> kafkaConnectors "Interacts"
      kafkaConnectors -> kafkaClusters "Interacts"
      kafkaClusters -> kafkaConsumers "Interacts"
      kafkaConsumers -> graphDB "Interacts"
      kafkaConsumers -> dataWarehouses "Interacts"
      kafkaConsumers -> dataMarts "Interacts"
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
        background #ffeb3b
      }

      element "Web Application" {
        shape roundedbox
        background #2196f3
        color #ffffff
      }
    }

    theme default
  }

}
