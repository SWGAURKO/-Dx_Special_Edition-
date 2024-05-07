CREATE TABLE IF NOT EXISTS 0r_jobcreator_jobs (
    id INT(11) NOT NULL AUTO_INCREMENT,
    identity VARCHAR(50) NOT NULL,
    name VARCHAR(64) NOT NULL,
    unique_name VARCHAR(64) NOT NULL,
    perm TEXT DEFAULT "{}",
    notify_type VARCHAR(64) NOT NULL,
    progressbar_type VARCHAR(64) NULL DEFAULT NULL,
    skillbar_type VARCHAR(64) NULL DEFAULT NULL,
    menu_type VARCHAR(64) NOT NULL,
    target_type VARCHAR(64) NOT NULL,
    textui_type VARCHAR(64) NOT NULL,
    start_type VARCHAR(50) NULL DEFAULT NULL,
    start_ped TEXT DEFAULT "{}",
    blip TEXT DEFAULT "{}",
    status ENUM("active", "deactive") NOT NULL DEFAULT "deactive",
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    KEY id (id),
    PRIMARY KEY (identity),
    UNIQUE KEY name (unique_name)
) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS 0r_jobcreator_job_steps (
    id INT(11) NOT NULL AUTO_INCREMENT,
    job_identity VARCHAR(50) NOT NULL,
    title VARCHAR(256) NOT NULL,
    coords TEXT DEFAULT "{}",
    radius FLOAT NULL DEFAULT "1.5",
    interaction_type ENUM("target", "textui", "draw_text_marker") NOT NULL DEFAULT "target",
    cool_down INT(11) NOT NULL,
    required_item TEXT NOT NULL DEFAULT "{}",
    animation TEXT DEFAULT "{}",
    remove_item TEXT DEFAULT "{}",
    give_item TEXT DEFAULT "{}",
    give_money TEXT DEFAULT "{}",
    remove_money TEXT DEFAULT "{}",
    blip TEXT DEFAULT "{}",
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    FOREIGN KEY (job_identity) REFERENCES 0r_jobcreator_jobs(identity) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS 0r_jobcreator_job_teleports (
    id INT(11) NOT NULL AUTO_INCREMENT,
    job_identity VARCHAR(50) NOT NULL,
    name VARCHAR(64) NOT NULL,
    interaction_type ENUM("target", "textui", "draw_text_marker") NOT NULL DEFAULT "target",
    type ENUM("one-way", "two-way") NOT NULL DEFAULT "one-way",
    entry_coords TEXT DEFAULT "{}",
    exit_coords TEXT DEFAULT "{}",
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    FOREIGN KEY (job_identity) REFERENCES 0r_jobcreator_jobs(identity) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS 0r_jobcreator_job_objects (
    id INT(11) NOT NULL AUTO_INCREMENT,
    job_identity VARCHAR(50) NOT NULL,
    name VARCHAR(64) NOT NULL,
    coords TEXT DEFAULT "{}",
    type VARCHAR(64) NOT NULL,
    model_hash VARCHAR(256) NOT NULL,
    is_network ENUM("yes", "no") NOT NULL DEFAULT "no",
    net_mission_entity ENUM("yes", "no") NOT NULL DEFAULT "no",
    door_flag ENUM("yes", "no") NOT NULL DEFAULT "no",
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    FOREIGN KEY (job_identity) REFERENCES 0r_jobcreator_jobs(identity) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS 0r_jobcreator_job_car_spawners (
    id INT(11) NOT NULL AUTO_INCREMENT,
    job_identity VARCHAR(50) NOT NULL,
    name VARCHAR(64) NOT NULL,
    interaction_type ENUM("target", "textui", "draw_text_marker") NOT NULL DEFAULT "target",
    coords TEXT DEFAULT "{}",
    car_spawner_coords TEXT DEFAULT "{}",
    cars TEXT DEFAULT "{}",
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    FOREIGN KEY (job_identity) REFERENCES 0r_jobcreator_jobs(identity) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS 0r_jobcreator_job_stashes (
    id INT(11) NOT NULL AUTO_INCREMENT,
    job_identity VARCHAR(50) NOT NULL,
    name VARCHAR(64) NOT NULL,
    unique_name VARCHAR(64) NOT NULL,
    interaction_type ENUM("target", "textui", "draw_text_marker") NOT NULL DEFAULT "target",
    coords TEXT DEFAULT "{}",
    size INT(11) NOT NULL,
    slots INT(11) NOT NULL,
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    UNIQUE KEY name (unique_name),
    FOREIGN KEY (job_identity) REFERENCES 0r_jobcreator_jobs(identity) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS 0r_jobcreator_job_markets (
    id INT(11) NOT NULL AUTO_INCREMENT,
    job_identity VARCHAR(50) NOT NULL,
    name VARCHAR(64) NOT NULL,
    interaction_type ENUM("target", "textui", "draw_text_marker") NOT NULL DEFAULT "target",
    ped_coords TEXT DEFAULT "{}",
    ped_model_hash VARCHAR(255) NOT NULL,
    items TEXT DEFAULT "{}",
    author VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    FOREIGN KEY (job_identity) REFERENCES 0r_jobcreator_jobs(identity) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;