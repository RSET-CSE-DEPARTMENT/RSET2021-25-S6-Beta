# importing the packages we will be using for this project
import pandas as pd
# setting pandas display to avoid scientific notation in my dataframes
pd.options.display.float_format = '{:.3f}'.format
# import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


# reading the csv file
df = pd.read_csv('C:/Users/gmelo/OneDrive/Desktop/mini/fetal_health.csv')

# previewing the DataFrame
print(df.head())
#getting info
df.info()
#getting no.of rows and columns of datafrane
print(df.shape)
#summary statistics of the numerical columns in your DataFrame, such as count, mean, standard deviation, minimum, and quartiles.
print(df.describe())
# plotting acceleration frequencies
sns.set_palette(palette='coolwarm')
df.accelerations.hist()
plt.title('Accelerations Frequencies');
plt.show()
# plotting uterine contractions frequencies
df.uterine_contractions.hist()
plt.title('uterine contractions');
plt.show()
# getting value counts for severe decelaration
print(df.severe_decelerations.value_counts())
# plotting fetal movement frequencies
df.abnormal_short_term_variability.hist()
plt.title('Abnormal Short-Term Variability');
plt.show()
df.percentage_of_time_with_abnormal_long_term_variability.hist()
plt.title('Abnormal long-Term Variability');
plt.show()
df.baseline_value.hist()
plt.title('baseline heart rate');
plt.show()




