/* permissions to EM for get tendered votelist form*/
INSERT INTO `security`.`url_permission` (`url`, `name`) VALUES ('/reports/gettenderedvotelist', 'GET_TENDERED_VOTE_LIST');
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('7', last_insert_id());

SELECT id into @id FROM security.url_permission where url='/reports/gettenderedvotelist';
INSERT INTO `security`.`role_url_permission` (`role_id`, `permission_id`) VALUES ('2', @id);