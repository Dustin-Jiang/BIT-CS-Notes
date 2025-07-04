DROP VIEW IF EXISTS region_view;
DROP TABLE IF EXISTS region;

CREATE TABLE region (
  id VARCHAR(6) NOT NULL PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  -- 变更后的编号
  replaced_by VARCHAR(6),
  UNIQUE(id)
);

CREATE VIEW region_view AS
SELECT 
    l.id,
    COALESCE(r.name, l.name) AS name,
    l.replaced_by
FROM region l
LEFT JOIN region r ON l.replaced_by = r.id;

INSERT INTO region (id, name, replaced_by) VALUES
('110000', '北京市', NULL),
('110100', '北京市市辖区', NULL),
('110200', '北京市县','110100'),
('120000', '天津市', NULL),
('120100', '天津市市辖区', NULL),
('120200', '天津市县','120100'),
('130000', '河北省', NULL),
('130100', '河北省石家庄市', NULL),
('130200', '河北省唐山市', NULL),
('130300', '河北省秦皇岛市', NULL),
('130400', '河北省邯郸市', NULL),
('130500', '河北省邢台市', NULL),
('130600', '河北省保定市', NULL),
('130700', '河北省张家口市', NULL),
('130800', '河北省承德市', NULL),
('130900', '河北省沧州市', NULL),
('131000', '河北省廊坊市', NULL),
('131100', '河北省衡水市', NULL),
('140000', '山西省', NULL),
('140100', '山西省太原市', NULL),
('140200', '山西省大同市', NULL),
('140300', '山西省阳泉市', NULL),
('140400', '山西省长治市', NULL),
('140500', '山西省晋城市', NULL),
('140600', '山西省朔州市', NULL),
('140700', '山西省晋中市', NULL),
('140800', '山西省运城市', NULL),
('140900', '山西省忻州市', NULL),
('141000', '山西省临汾市', NULL),
('141100', '山西省吕梁市', NULL),
('142100', '山西省雁北地区','140200'),
('142200', '山西省忻州地区','140900'),
('142300', '山西省忻州地区吕梁地区','141100'),
('142400', '山西省晋中地区','140700'),
('142500', '山西省晋东南地区','140500'),
('142600', '山西省临汾地区','141000'),
('142700', '山西省运城地区','140800'),
('150000', '内蒙古自治区', NULL),
('150100', '内蒙古自治区呼和浩特市', NULL),
('150200', '内蒙古自治区包头市', NULL),
('150300', '内蒙古自治区乌海市', NULL),
('150400', '内蒙古自治区赤峰市', NULL),
('150500', '内蒙古自治区通辽市', NULL),
('150600', '内蒙古自治区鄂尔多斯市', NULL),
('150700', '内蒙古自治区呼伦贝尔市', NULL),
('150800', '内蒙古自治区巴彦淖尔市', NULL),
('150900', '内蒙古自治区乌兰察布市', NULL),
('152100', '内蒙古自治区', NULL),
('152200', '内蒙古自治区兴安盟', NULL),
('152300', '内蒙古自治区哲里木盟', '150500'),
('152400', '内蒙古自治区', NULL),
('152500', '内蒙古自治区锡林郭勒盟', NULL),
('152600', '内蒙古自治区乌兰察布盟', NULL),
('152700', '内蒙古自治区伊克昭盟', NULL),
('152800', '内蒙古自治区巴彦淖尔盟', NULL),
('152900', '内蒙古自治区阿拉善盟', NULL),
('210000', '辽宁省', NULL),
('210100', '辽宁省沈阳市', NULL),
('210200', '辽宁省大连市', NULL),
('210300', '辽宁省鞍山市', NULL),
('210400', '辽宁省抚顺市', NULL),
('210500', '辽宁省本溪市', NULL),
('210600', '辽宁省丹东市', NULL),
('210700', '辽宁省锦州市', NULL),
('210800', '辽宁省营口市', NULL),
('210900', '辽宁省阜新市', NULL),
('211000', '辽宁省辽阳市', NULL),
('211100', '辽宁省盘锦市', NULL),
('211200', '辽宁省铁岭市', NULL),
('211300', '辽宁省朝阳市', NULL),
('211400', '辽宁省葫芦岛市', NULL),
('220000', '吉林省', NULL),
('220100', '吉林省长春市', NULL),
('220200', '吉林省吉林市', NULL),
('220300', '吉林省四平市', NULL),
('220400', '吉林省辽源市', NULL),
('220500', '吉林省通化市', NULL),
('220600', '吉林省白山市', NULL),
('220700', '吉林省松原市', NULL),
('220800', '吉林省白城市', NULL),
('222100', '吉林省四平地区', '220300'),
('222300', '吉林省白城地区', '220800'),
('222400', '吉林省延边朝鲜族自治州', NULL),
('230000', '黑龙江省', NULL),
('230100', '黑龙江省哈尔滨市', NULL),
('230200', '黑龙江省齐齐哈尔市', NULL),
('230300', '黑龙江省鸡西市', NULL),
('230400', '黑龙江省鹤岗市', NULL),
('230500', '黑龙江省双鸭山市', NULL),
('230600', '黑龙江省大庆市', NULL),
('230700', '黑龙江省伊春市', NULL),
('230800', '黑龙江省佳木斯市', NULL),
('230900', '黑龙江省七台河市', NULL),
('231000', '黑龙江省牡丹江市', NULL),
('231100', '黑龙江省黑河市', NULL),
('231200', '黑龙江省绥化市', NULL),
('232100', '黑龙江省松花江地区', '230100'),
('232200', '黑龙江省嫩江地区', '230200'),
('232300', '黑龙江省绥化地区', '231200'),
('232400', '黑龙江省合江地区', '230800'),
('232500', '黑龙江省牡丹江地区', '231000'),
('232600', '黑龙江省黑河地区', '231100'),
('232700', '黑龙江省大兴安岭地区', NULL),
('310000', '上海市', NULL),
('310100', '上海市市辖区', NULL),
('310200', '上海市县',''),
('320000', '江苏省', NULL),
('320100', '江苏省南京市', NULL),
('320200', '江苏省无锡市', NULL),
('320300', '江苏省徐州市', NULL),
('320400', '江苏省常州市', NULL),
('320500', '江苏省苏州市', NULL),
('320600', '江苏省南通市', NULL),
('320700', '江苏省连云港市', NULL),
('320800', '江苏省淮阴市', NULL),
('320900', '江苏省盐城市', NULL),
('321000', '江苏省扬州市', NULL),
('321100', '江苏省镇江市', NULL),
('321200', '江苏省泰州市', NULL),
('321300', '江苏省宿迁市', NULL),
('330000', '浙江省', NULL),
('330100', '浙江省杭州市', NULL),
('330200', '浙江省宁波市', NULL),
('330300', '浙江省温州市', NULL),
('330400', '浙江省嘉兴市', NULL),
('330500', '浙江省湖州市', NULL),
('330600', '浙江省绍兴市', NULL),
('330700', '浙江省金华市', NULL),
('330800', '浙江省衢州市', NULL),
('330900', '浙江省舟山市', NULL),
('331000', '浙江省台州市', NULL),
('331100', '浙江省丽水市', NULL),
('332300', '浙江省绍兴地区','330600'),
('332400', '浙江省金华地区','330700'),
('332500', '浙江省丽水地区','331100'),
('332600', '浙江省台州地区','331000'),
('340000', '安徽省', NULL),
('340100', '安徽省合肥市', NULL),
('340200', '安徽省芜湖市', NULL),
('340300', '安徽省蚌埠市', NULL),
('340400', '安徽省淮南市', NULL),
('340500', '安徽省马鞍山市', NULL),
('340600', '安徽省淮北市', NULL),
('340700', '安徽省铜陵市', NULL),
('340800', '安徽省安庆市', NULL),
('340900', '安徽省直辖县', '341000'),
('341000', '安徽省黄山市', NULL),
('341100', '安徽省滁州市', NULL),
('341200', '安徽省阜阳市', NULL),
('341300', '安徽省宿州市', NULL),
('341400', '安徽省巢湖市','340100'),
('341500', '安徽省六安市', NULL),
('341600', '安徽省亳州市', NULL),
('341700', '安徽省池州市', NULL),
('341800', '安徽省宣城市', NULL),
('342400', '安徽省六安地区','341500'),
('342500', '安徽省宣城地区','341800'),
('342600', '安徽省巢湖地区','340100'),
('342900', '安徽省池州地区','341700'),
('350000', '福建省', NULL),
('350100', '福建省福州市', NULL),
('350200', '福建省厦门市', NULL),
('350300', '福建省莆田市', NULL),
('350400', '福建省三明市', NULL),
('350500', '福建省泉州市', NULL),
('350600', '福建省漳州市', NULL),
('350700', '福建省南平市', NULL),
('350800', '福建省龙岩市', NULL),
('350900', '福建省宁德市', NULL),
('352200', '福建省宁德地区','350900'),
('360000', '江西省', NULL),
('360100', '江西省南昌市', NULL),
('360200', '江西省景德镇市', NULL),
('360300', '江西省萍乡市', NULL),
('360400', '江西省九江市', NULL),
('360500', '江西省新余市', NULL),
('360600', '江西省鹰潭市', NULL),
('360700', '江西省赣州市', NULL),
('360800', '江西省吉安市', NULL),
('360900', '江西省宜春市', NULL),
('361000', '江西省抚州市', NULL),
('361100', '江西省上饶市', NULL),
('362200', '江西省宜春地区','360900'),
('362300', '江西省上饶地区','361100'),
('362400', '江西省吉安地区','360800'),
('362500', '江西省抚州地区','361000'),
('370000', '山东省', NULL),
('370100', '山东省济南市', NULL),
('370200', '山东省青岛市', NULL),
('370300', '山东省淄博市', NULL),
('370400', '山东省枣庄市', NULL),
('370500', '山东省东营市', NULL),
('370600', '山东省烟台市', NULL),
('370700', '山东省潍坊市', NULL),
('370800', '山东省济宁市', NULL),
('370900', '山东省泰安市', NULL),
('371000', '山东省威海市', NULL),
('371100', '山东省日照市', NULL),
('371200', '山东省莱芜市', NULL),
('371300', '山东省临沂市', NULL),
('371400', '山东省德州市', NULL),
('371500', '山东省聊城市', NULL),
('371600', '山东省滨州市', NULL),
('371700', '山东省菏泽市', NULL),
('372300', '山东省滨州地区','371600'),
('372900', '山东省菏泽地区','371700'),
('410000', '河南省', NULL),
('410100', '河南省郑州市', NULL),
('410200', '河南省开封市', NULL),
('410300', '河南省洛阳市', NULL),
('410400', '河南省平顶山市', NULL),
('410500', '河南省安阳市', NULL),
('410600', '河南省鹤壁市', NULL),
('410700', '河南省新乡市', NULL),
('410800', '河南省焦作市', NULL),
('410900', '河南省濮阳市', NULL),
('411000', '河南省许昌市', NULL),
('411100', '河南省漯河市', NULL),
('411200', '河南省三门峡市', NULL),
('411300', '河南省南阳市', NULL),
('411400', '河南省商丘市', NULL),
('411500', '河南省信阳市', NULL),
('411600', '河南省周口市', NULL),
('411700', '河南省驻马店市', NULL),
('412700', '河南省周口地区','411600'),
('412800', '河南省驻马店地区','411700'),
('419000', '河南省直辖县', NULL),
('420000', '湖北省', NULL),
('420100', '湖北省武汉市', NULL),
('420200', '湖北省黄石市', NULL),
('420300', '湖北省十堰市', NULL),
('420400', '湖北省沙市市','421000'),
('420500', '湖北省宜昌市', NULL),
('420600', '湖北省襄樊市', NULL),
('420700', '湖北省鄂州市', NULL),
('420800', '湖北省荆门市', NULL),
('420900', '湖北省孝感市', NULL),
('421000', '湖北省荆州市', NULL),
('421100', '湖北省黄冈市', NULL),
('421200', '湖北省咸宁市', NULL),
('421300', '湖北省随州市', NULL),
('422800', '湖北省施土家族苗族自治州', NULL),
('429000', '湖北省直辖县', NULL),
('430000', '湖南省', NULL),
('430100', '湖南省长沙市', NULL),
('430200', '湖南省株洲市', NULL),
('430300', '湖南省湘潭市', NULL),
('430400', '湖南省衡阳市', NULL),
('430500', '湖南省邵阳市', NULL),
('430600', '湖南省岳阳市', NULL),
('430700', '湖南省常德市', NULL),
('430800', '湖南省张家界市', NULL),
('430900', '湖南省益阳市', NULL),
('431000', '湖南省郴州市', NULL),
('431100', '湖南省永州市', NULL),
('431200', '湖南省怀化市', NULL),
('431300', '湖南省娄底市', NULL),
('432500', '湖南省娄底地区','431300'),
('433000', '湖南省怀化市', NULL),
('433100', '湖南省湘西土家族苗族自治州', NULL),
('440000', '广东省', NULL),
('440100', '广东省广州市', NULL),
('440200', '广东省韶关市', NULL),
('440300', '广东省深圳市', NULL),
('440400', '广东省珠海市', NULL),
('440500', '广东省汕头市', NULL),
('440600', '广东省佛山市', NULL),
('440700', '广东省江门市', NULL),
('440800', '广东省湛江市', NULL),
('440900', '广东省茂名市', NULL),
('441000', '广东省海口市', '460100'),
('441100', '广东省三亚市', '460200'),
('441200', '广东省肇庆市', NULL),
('441300', '广东省惠州市', NULL),
('441400', '广东省梅州市', NULL),
('441500', '广东省汕尾市', NULL),
('441600', '广东省河源市', NULL),
('441700', '广东省阳江市', NULL),
('441800', '广东省清远市', NULL),
('441900', '广东省东莞市', NULL),
('442000', '广东省中山市', NULL),
('442100', '广东省海南行政区', '460000'),
('445100', '广东省潮州市', NULL),
('445200', '广东省揭阳市', NULL),
('445300', '广东省云浮市', NULL),
('450000', '广西壮族自治区', NULL),
('450100', '广西壮族自治区南宁市', NULL),
('450200', '广西壮族自治区柳州市', NULL),
('450300', '广西壮族自治区桂林市', NULL),
('450400', '广西壮族自治区梧州市', NULL),
('450500', '广西壮族自治区北海市', NULL),
('450600', '广西壮族自治区防城港市', NULL),
('450700', '广西壮族自治区钦州市', NULL),
('450800', '广西壮族自治区贵港市', NULL),
('450900', '广西壮族自治区玉林市', NULL),
('451000', '广西壮族自治区百色市', NULL),
('451100', '广西壮族自治区贺州市', NULL),
('451200', '广西壮族自治区河池市', NULL),
('451300', '广西壮族自治区来宾市', NULL),
('451400', '广西壮族自治区崇左市', NULL),
('452100', '广西壮族自治区南宁地区', NULL),
('452200', '广西壮族自治区柳州地区','450200'),
('452300', '广西壮族自治区桂林地区','450300'),
('452400', '广西壮族自治区贺州地区','451100'),
('452600', '广西壮族自治区百色地区','451000'),
('452700', '广西壮族自治区河池地区','451200'),
('452800', '广西壮族自治区钦州地区','450700'),
('460000', '海南省', NULL),
('460100', '海南省海口市', NULL),
('460200', '海南省三亚市', NULL),
('460300', '海南省三沙市', NULL),
('500000', '重庆市', NULL),
('500100', '重庆市市辖区', NULL),
('500200', '重庆市县', NULL),
('500300', '重庆市县级市', NULL),
('510000', '四川省', NULL),
('510100', '四川省成都市', NULL),
('510200', '四川省重庆市','500000'),
('510300', '四川省自贡市', NULL),
('510400', '四川省攀枝花市', NULL),
('510500', '四川省泸州市', NULL),
('510600', '四川省德阳市', NULL),
('510700', '四川省绵阳市', NULL),
('510800', '四川省广元市', NULL),
('510900', '四川省遂宁市', NULL),
('511000', '四川省内江市', NULL),
('511100', '四川省乐山市', NULL),
('511200', '四川省万县市','500100'),
('511300', '四川省南充市', NULL),
('511400', '四川省眉山市', NULL),
('511500', '四川省宜宾市', NULL),
('511600', '四川省广安市', NULL),
('511700', '四川省达州市', NULL),
('511800', '四川省雅安市', NULL),
('511900', '四川省巴中市', NULL),
('512000', '四川省资阳市', NULL),
('513000', '四川省达川地区','511700'),
('513100', '四川省雅安地区','511800'),
('513200', '四川省阿坝藏族羌族自治州', NULL),
('513300', '四川省甘孜藏族自治州', NULL),
('513400', '四川省凉山彝族自治州', NULL),
('513700', '四川省巴中地区','511900'),
('513800', '四川省眉山地区','511400'),
('513900', '四川省眉山地区资阳地区','512000'),
('520000', '贵州省', NULL),
('520100', '贵州省贵阳市', NULL),
('520200', '贵州省六盘水市', NULL),
('520300', '贵州省遵义市', NULL),
('520400', '贵州省安顺市', NULL),
('520500', '贵州省毕节市', NULL),
('520600', '贵州省铜仁市', NULL),
('522100', '贵州省遵义地区','520300'),
('522200', '贵州省铜仁地区','520600'),
('522300', '贵州省黔西南布依族苗族自治州', NULL),
('522400', '贵州省毕节地区','520500'),
('522500', '贵州省安顺地区','520400'),
('522600', '贵州省黔东南苗族侗族自治州', NULL),
('522700', '贵州省黔南布依族苗族自治州', NULL),
('530000', '云南省', NULL),
('530100', '云南省昆明市', NULL),
('530200', '云南省东川市', NULL),
('530300', '云南省曲靖市', NULL),
('530400', '云南省玉溪市', NULL),
('530500', '云南省保山市', NULL),
('530600', '云南省昭通市', NULL),
('530700', '云南省丽江市', NULL),
('530800', '云南省普洱市', NULL),
('530900', '云南省临沧市', NULL),
('532100', '云南省昭通地区','530600'),
('532200', '云南省曲靖地区','530300'),
('532300', '云南省楚雄彝族自治州', NULL),
('532400', '云南省玉溪地区','530400'),
('532500', '云南省红河哈尼族彝族自治州', NULL),
('532600', '云南省文山壮族苗族自治州', NULL),
('532700', '云南省思茅地区','530800'),
('532800', '云南省西双版纳傣族自治州', NULL),
('532900', '云南省大理白族自治州', NULL),
('533000', '云南省保山地区','530500'),
('533100', '云南省德宏傣族景颇族自治州', NULL),
('533200', '云南省丽江地区','530700'),
('533300', '云南省怒江傈僳族自治州', NULL),
('533400', '云南省迪庆藏族自治州', NULL),
('533500', '云南省临沧地区','530900'),
('540000', '西藏自治区', NULL),
('540100', '西藏自治区拉萨市', NULL),
('540200', '西藏自治区日喀则市', NULL),
('540300', '西藏自治区昌都市', NULL),
('540400', '西藏自治区林芝市', NULL),
('540500', '西藏自治区山南市', NULL),
('540600', '西藏自治区那曲市', NULL),
('542100', '西藏自治区昌都地区','540300'),
('542200', '西藏自治区山南地区','540500'),
('542300', '西藏自治区日喀则地区','540200'),
('542400', '西藏自治区那曲地区','540600'),
('542500', '西藏自治区阿里地区', NULL),
('542600', '西藏自治区林芝地区','540400'),
('610000', '陕西省', NULL),
('610100', '陕西省西安市', NULL),
('610200', '陕西省铜川市', NULL),
('610300', '陕西省宝鸡市', NULL),
('610400', '陕西省咸阳市', NULL),
('610500', '陕西省渭南市', NULL),
('610600', '陕西省延安市', NULL),
('610700', '陕西省汉中市', NULL),
('610800', '陕西省榆林市', NULL),
('610900', '陕西省安康市', NULL),
('611000', '陕西省商洛市', NULL),
('612400', '陕西省安康地区','610900'),
('612500', '陕西省商洛地区','611000'),
('612700', '陕西省榆林地区','610800'),
('620000', '甘肃省', NULL),
('620100', '甘肃省兰州市', NULL),
('620200', '甘肃省嘉峪关市', NULL),
('620300', '甘肃省金昌市', NULL),
('620400', '甘肃省白银市', NULL),
('620500', '甘肃省天水市', NULL),
('620600', '甘肃省武威市', NULL),
('620700', '甘肃省张掖市', NULL),
('620800', '甘肃省平凉市', NULL),
('620900', '甘肃省酒泉市', NULL),
('621000', '甘肃省庆阳市', NULL),
('621100', '甘肃省定西市', NULL),
('621200', '甘肃省陇南市', NULL),
('622100', '甘肃省酒泉地区','620900'),
('622200', '甘肃省张掖地区','620700'),
('622300', '甘肃省武威地区','620600'),
('622400', '甘肃省定西地区','621100'),
('622600', '甘肃省陇南地区','621200'),
('622700', '甘肃省平凉地区','620800'),
('622800', '甘肃省庆阳地区','621000'),
('622900', '甘肃省临夏回族自治州', NULL),
('623000', '甘肃省甘南藏族自治州', NULL),
('630000', '青海省', NULL),
('630100', '青海省西宁市', NULL),
('630200', '青海省海东市', NULL),
('632100', '青海省海东地区','630200'),
('632200', '青海省海北藏族自治州', NULL),
('632300', '青海省黄南藏族自治州', NULL),
('632500', '青海省海南藏族自治州', NULL),
('632600', '青海省果洛藏族自治州', NULL),
('632700', '青海省玉树藏族自治州', NULL),
('632800', '青海省海西蒙古族藏族自治州', NULL),
('640000', '宁夏回族自治区', NULL),
('640100', '宁夏回族自治区银川市', NULL),
('640200', '宁夏回族自治区石嘴山市', NULL),
('640300', '宁夏回族自治区吴忠市', NULL),
('640400', '宁夏回族自治区固原市', NULL),
('640500', '宁夏回族自治区中卫市', NULL),
('642200', '宁夏回族自治区固原地区','640400'),
('650000', '新疆维吾尔自治区', NULL),
('650100', '新疆维吾尔族自治区乌鲁木齐市', NULL),
('650200', '新疆维吾尔族自治区克拉玛依市', NULL),
('650300', '新疆维吾尔族自治区石河子市','659000'),
('650400', '新疆维吾尔族自治区吐鲁番市', NULL),
('652100', '新疆维吾尔族自治区吐鲁番地区', NULL),
('652200', '新疆维吾尔族自治区哈密地区', NULL),
('652300', '新疆维吾尔族自治区昌吉回族自治州', NULL),
('652700', '新疆维吾尔族自治区博尔塔拉蒙古自治州', NULL),
('652800', '新疆维吾尔族自治区巴音郭楞蒙古自治州', NULL),
('652900', '新疆维吾尔族自治区阿克苏地区', NULL),
('653000', '新疆维吾尔族自治区克孜勒苏柯尔克孜自治州', NULL),
('653100', '新疆维吾尔族自治区喀什地区', NULL),
('653200', '新疆维吾尔族自治区和田地区', NULL),
('654000', '新疆维吾尔族自治区伊犁哈萨克自治州', NULL),
('654100', '新疆维吾尔族自治区伊犁哈萨克自治州伊犁地区', NULL),
('654200', '新疆维吾尔族自治区塔城地区', NULL),
('654300', '新疆维吾尔族自治区阿勒泰地区', NULL),
('659000', '新疆维吾尔族自治区直辖县级行政单位', NULL);