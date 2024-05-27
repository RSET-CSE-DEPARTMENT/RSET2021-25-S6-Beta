# importing the packages we will be using for this project
import pandas as pd
# to format floating point numbers in dataframe upto 3 decimal
pd.options.display.float_format = '{:.3f}'.format
import numpy as np
import matplotlib.pyplot as plt
import pickle
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, recall_score, f1_score, confusion_matrix, classification_report, precision_recall_curve
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn import svm
from sklearn.preprocessing import StandardScaler
df = pd.read_csv('fetal_health.csv')
# handling missing data
df = df.dropna()
y = df['fetal_health']
X = df.drop(columns='fetal_health')
# feature scaling
scaler = StandardScaler()

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
X_test=scaler.fit_transform(X_test)
X_train=scaler.fit_transform(X_train)
tree_clf = RandomForestClassifier( random_state=0)
# tree_clf = svm.SVC()
# tree_clf = LogisticRegression()
#training
tree_clf.fit(X_train, y_train)
y_pred = tree_clf.predict(X_test)

# confusion matrix and classification report
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))
x=[[120.0,0.0,0.0,0.0,0.0,0.0,0.0,73.0,0.5,43.0,2.4,64.0,62.0,126.0,2.0,0.0,120.0,137.0,121.0,73.0,1.0]]
X.loc[len(X.index)] = x[0]
X=scaler.fit_transform(X)
x=[X[-1]]
out=tree_clf.predict(x)
with open('dt.pkl', 'wb') as f:  # open a text file
    pickle.dump(tree_clf, f)
print(out)