CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- resources
CREATE TABLE users (
    id uuid NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    auth0_id TEXT NOT NULL UNIQUE,
    label TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE knowledge_nodes (
    id uuid NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    label TEXT NOT NULL UNIQUE,
    exclusive_user_id uuid REFERENCES users (id)
);

CREATE TABLE knowledge_node_closure_table (
    ancestor_node_id uuid NOT NULL REFERENCES knowledge_nodes (id),
    descendant_node_id uuid NOT NULL REFERENCES knowledge_nodes (id),
    depth bigint NOT NULL,
    PRIMARY KEY (ancestor_node_id, descendant_node_id)
);

-- events
CREATE TABLE knowledge_node_descriptions (
    id uuid NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    knowledge_node_id uuid NOT NULL REFERENCES knowledge_nodes (id),
    user_id uuid NOT NULL REFERENCES users (id),
    description TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
