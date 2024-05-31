import pickle
import pandas as pd
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()

def predict_fetal_health(x):
   with open(r"./ml/dt.pkl", "rb") as f:
      e = pickle.load(f)
   df = pd.read_csv('./ml/fetal_health.csv')
   df = df.dropna()
   X = df.drop(columns='fetal_health')
   X.loc[len(X.index)] = x
   X = scaler.fit_transform(X)
   x = [X[-1]]
   out = e.predict(x)
   if out[0] == 1:
      return "Normal"
   elif out[0] == 2:
      return "Abnormal"
   else:
      return "Pathological"
   

