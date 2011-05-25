import redis,MySQLdb, sys
conn=MySQLdb.connect(host=sys.argv[1], user='mk',passwd='magic_kitchen',db='magic_kitchen')
cur=conn.cursor()
r=redis.Redis(sys.argv[2])
cur.execute('SELECT recipe_id,SUM(coeff) AS Score FROM recipes_ingredients AS ri INNER JOIN users_ingredients AS ui ON ri.ingredient_id=ui.ingredient_id WHERE user_id=%s AND recipe_id NOT IN (SELECT recipe_id FROM favorites WHERE user_id=%s) GROUP BY recipe_id ORDER BY Score DESC LIMIT 20',(sys.argv[3],sys.argv[3]))
liste=cur.fetchall()
ref=liste[0]
score=ref[1]
for i in liste:
  r.rpush('User:'+sys.argv[2]+':recipes_recommandations',str(i[0])+':'+str(int(i[1]/score*100)))
  r.ltrim('User:'+sys.argv[2]+':recipes_recommandations',0,9)