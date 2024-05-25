import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { LineChart } from 'react-native-chart-kit';

const ProductivityGraph = () => {
  const data = {
    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    datasets: [
      {
        data: [20, 45, 28, 80, 99, 43, 60],
      },
    ],
  };

  return (
    <View style={styles.container}>
      <Text style={styles.heading}>Weekly Productivity</Text>
      <LineChart
        data={data}
        width={350} // Adjust width as needed
        height={200} // Adjust height as needed
        yAxisSuffix="hrs"
        chartConfig={{
          backgroundColor: '#e6f0ff', // Background color
          backgroundGradientFrom: '#ffffff', // Gradient background color from
          backgroundGradientTo: '#ffffff', // Gradient background color to
          decimalPlaces: 0, // No decimal places
          color: (opacity = 1) => `rgba(0, 128, 0, ${opacity})`, // Line color
          labelColor: (opacity = 1) => `rgba(0, 0, 0, ${opacity})`, // Label color
          propsForDots: {
            r: '6', // Dot radius
            strokeWidth: '2', // Dot stroke width
            stroke: '#ffa500', // Dot stroke color
          },
        }}
        bezier // Smooth line chart
        style={styles.chart}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
    alignItems: 'center',
  },
  heading: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  chart: {
    marginVertical: 8,
    borderRadius: 16,
  },
});

export default ProductivityGraph;
