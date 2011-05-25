import sys, MySQLdb
conn=MySQLdb.connect(host=sys.argv[1], user='mk',passwd='magic_kitchen',db='magic_kitchen')
cur=conn.cursor()
cur.execute('SELECT ingredient_id FROM recipes_ingredients WHERE recipe_id=%s',sys.argv[3])
for i in cur.fetchall():
  cur.execute('INSERT INTO users_ingredients (user_id,ingredient_id,weight,coeff) VALUES (%s,%s,%s,%s) ON DUPLICATE KEY UPDATE weight=weight+1',(sys.argv[2],i[0],1,0.0))
conn.commit()
conn.close()