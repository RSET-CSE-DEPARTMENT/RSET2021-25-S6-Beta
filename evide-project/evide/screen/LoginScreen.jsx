import {
  View,
  Text,
  TextInput,
  Button,
  Image,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
} from "react-native";
import React, { useState, useEffect } from "react";
import { useNavigation } from "@react-navigation/native";
import { initializeApp } from "@firebase/app";
import {
  getAuth,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
} from "@firebase/auth";

const firebaseConfig = {
  apiKey: "AIzaSyABnBPdTMxed_RHA_7y4r0i5GcJd3IyAU0",
  authDomain: "evide-auth.firebaseapp.com",
  projectId: "evide-auth",
  storageBucket: "evide-auth.appspot.com",
  messagingSenderId: "1069280240963",
  appId: "1:1069280240963:web:58636abeb1bf66a2627bf6",
  measurementId: "G-FBRYNW5CJ5",
};

const app = initializeApp(firebaseConfig);

const AuthScreen = ({
  email,
  setEmail,
  password,
  setPassword,
  isLogin,
  setIsLogin,
  handleAuthentication,
}) => {
  const navigation = useNavigation();

  const handleRegister = () => {
    navigation.navigate("Signup");
  };
  return (
    <View style={styles.container}>
      <View style={styles.topImageContainer}>
        <Image
          source={require("../assets/translogo.png")}
          style={styles.topImage}
        />
      </View>
      <View style={styles.helloContainer}>
        <Text style={styles.helloText}>Welcome </Text>
      </View>
      <View>
        <Text style={styles.signInText}>Log-in to your account </Text>
      </View>
      <View style={styles.inputContainer}>
        <TextInput
          style={styles.TextInput}
          value={email}
          onChangeText={setEmail}
          placeholder="Email"
          autoCapitalize="none"
        />
      </View>
      <View style={styles.inputContainer}>
        <TextInput
          style={styles.TextInput}
          value={password}
          onChangeText={setPassword}
          placeholder="Password"
          secureTextEntry
        />
      </View>

      <TouchableOpacity
        style={styles.logInButtonContainer}
        onPress={handleAuthentication}
        color="#3498db"
      >
        <Text style={styles.login}>{isLogin ? "Sign In" : "Sign Up"}</Text>
      </TouchableOpacity>

      <Text style={styles.footerText} onPress={() => setIsLogin(!isLogin)}>
        {isLogin
          ? "Need an account? Sign Up"
          : "Already have an account? Sign In"}
      </Text>

      {/* <Text style={styles.forgotPasswordText}>Forgot your password? </Text> */}
      {/* <View style={styles.logInButtonContainer}>
        <Text style={styles.login}>Login</Text>
      </View> */}
      {/* <TouchableOpacity onPress= {handleRegister}>
        <Text style={styles.footerText}>
          Dont have an account? {""}
          <Text style={{textDecorationLine:"underline"}}>Create</Text> </Text>
    </TouchableOpacity> */}
    </View>
  );
};

const AuthenticatedScreen = ({ user, handleAuthentication }) => {
  return (
    <View style={styles.authContainer}>
      <Text style={styles.title}>Welcome</Text>
      <Text style={styles.emailText}>{user.email}</Text>
      <Button title="Logout" onPress={handleAuthentication} color="#e74c3c" />
    </View>
  );
};

export default LoginScreen = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [user, setUser] = useState(null); // Track user authentication state
  const [isLogin, setIsLogin] = useState(true);

  const navigation = useNavigation()

  const auth = getAuth(app);
  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
      navigation.navigate('Input Screen')
    });

    return () => unsubscribe();
  }, [auth]);

  const handleAuthentication = async () => {
    try {
      if (user) {
        // If user is already authenticated, log out
        console.log("User logged out successfully!");
        await signOut(auth);
      } else {
        // Sign in or sign up
        if (isLogin) {
          // Sign in
          await signInWithEmailAndPassword(auth, email, password);
          console.log("User signed in successfully!");
        } else {
          // Sign up
          await createUserWithEmailAndPassword(auth, email, password);
          console.log("User created successfully!");
        }
      }
    } catch (error) {
      console.error("Authentication error:", error.message);
    }
  };

  return (
    <ScrollView contentContainerStyle={styles.container}>
      {user ? (
        // Show user's email if user is authenticated
        <AuthenticatedScreen
          user={user}
          handleAuthentication={handleAuthentication}
        />
      ) : (
        // Show sign-in or sign-up form if user is not authenticated
        <AuthScreen
          email={email}
          setEmail={setEmail}
          password={password}
          setPassword={setPassword}
          isLogin={isLogin}
          setIsLogin={setIsLogin}
          handleAuthentication={handleAuthentication}
        />
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: "white",
    flex: 1,
  },
  topImageContainer: {
    height: 200,
  },
  topImage: {
    width: "50%",
    height: 400,
  },
  helloContainer: {
    alignItems: "center",
    bottom: "3%",
  },
  helloText: {
    //font-family: "Inter",
    textAlign: "center",
    fontSize: 48,
    fontWeight: "450",
    color: "black",
  },
  signInText: {
    textAlign: "center",
    fontWeight: "250",
    fontSize: 16,
    marginBottom: 5,
  },
  inputContainer: {
    backgroundColor: "white",
    flexDirection: "row",
    borderRadius: 19,
    marginHorizontal: 60,
    height: 45,
    elevation: 0,
    marginVertical: 10,
    alignItems: "center",
    borderBottomWidth: 0.2,
    top: "10%",
  },
  TextInput: {
    flex: 1,
    marginHorizontal: 30,
  },
  forgotPasswordText: {
    color: "#BEBEBE",
    textAlign: "right",
    width: "82%",
    height: "10%",
    fontSize: 13,
    top: "5%",
  },
  logInButtonContainer: {
    alignSelf: "center",
    borderRadius: 14,
    paddingVertical: 12,
    paddingHorizontal: 2,
    backgroundColor: "#15C679",
    width: 250,
    top: "2%",
  },
  login: {
    color: "white",
    fontSize: 15,
    textAlign: "center",
  },
  footerText: {
    color: "#262626",
    textAlign: "center",
    marginTop: 90, //height
  },
});
