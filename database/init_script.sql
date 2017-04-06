/**creates the organization **/
INSERT INTO `subscription`.`organization`
(
`name`,
`code`,
`area_name`,
`address1`,
`address2`,
`postcode`,
`state`,
`province`,
`email`,
`logo_url`
)
VALUES
(
'Derry City Council',
'DERRY',
'Derry',
'20, York Drive',
'Derry',
'DE8466Y',
'',
'',
'council@derry',
'/images/derrylogo.png'
);
/**creates the admin role **/
INSERT INTO `security`.`role`
(
`organization_id`,
`name`,
`description`)
VALUES
(
(select id from subscription.organization where name='Derry City Council'),
'admin',
'admin user');
/**creates the user **/
INSERT INTO `security`.`user`
(
`organization_id`,
`firstname`,
`lastname`,
`email`,
`username`,
`passwordhash`,
`passwordsalt`,
`apikey`,
`birthday`,
`gender`,
`timezone`,
`locale`,
`language_id`)
VALUES

((select id from subscription.organization where name='Derry City Council'),
'admin',
'user',
'admin@admin.com',
'admin',
sha1('S@l+VaLpass@123'),
'S@l+VaL',
'',
STR_TO_DATE('1-01-2012', '%d-%m-%Y'),
'M',
'',
'en-GB',
1);

/**creates the application **/
INSERT INTO `subscription`.`application`
(
`name`,
`description`)
VALUES
(
'PSM',
'Polling Station Manager');

/**creates all the permissions **/
INSERT INTO `subscription`.`permission`
(
`application_id`,
`name`,
`url`,
`verb`,
`permissioncode`)
VALUES
(
(select id from subscription.application where name='PSM'),
'Check the pulse for new notifications',
'',
'',
'getnewnotificationpulse');

/**creates election **/
INSERT INTO `psm`.`election`
(
`organization_id`,
`election_name`,
`election_date_start`,
`election_date_end`,
`status`)
VALUES
(
(select id from subscription.organization where name='Derry City Council'),
'Police Comminisoner Election',
STR_TO_DATE('1-01-2016', '%d-%m-%Y'),
STR_TO_DATE('1-01-2016', '%d-%m-%Y'),
0);
/**creates notification **/
INSERT INTO `psm`.`notification`
(
`organization_id`,
`election_id`,
`message`,
`attachtment_url`)
VALUES
(
(select id from subscription.organization where name='Derry City Council'),
(select id from psm.election where election_name='Police Comminisoner Election' ),
'Warning, check out for bombs',
''
);
/**creates notification status **/
INSERT INTO `psm`.`notification_status`
(
`organization_id`,
`notificationid`,
`userid`,
`status`,
`isprivate`)
VALUES
(
(select id from subscription.organization where name='Derry City Council'),
(select id from psm.notification where message='Warning, check out for bombs'),
(select id from security.user where username='admin'),
0,
0);


/**creates close station stats **/
insert into psm.election_close_stats (organization_id,election_id,tot_ballots,tot_spolied_issued,tot_unused,tot_tend_ballots,tot_tend_spoiled,tot_tend_unused)
values ((select id from subscription.organization where name='Derry City Council'),(select id from psm.election where election_name='Police Comminisoner Election' ),5000,21,433,4230,22,12);


