"use client";

import Image from "next/image";
import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button/Button";
import { Card } from "@/components/ui/card/Card";
import { useTheme } from "@/components/ui/theme-toggle/ThemeProvider";
import { motion } from "framer-motion";

export default function Home() {
  const { theme, toggleTheme } = useTheme();
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
  }, []);

  // Animation variants
  const fadeIn = {
    hidden: { opacity: 0, y: 20 },
    visible: { 
      opacity: 1, 
      y: 0,
      transition: { 
        duration: 0.6,
        ease: "easeOut"
      }
    }
  };

  const staggerChildren = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2
      }
    }
  };

  const featureItems = [
    {
      title: "Modern UI",
      description: "Clean and intuitive interface with responsive design for all devices",
      icon: "🎨"
    },
    {
      title: "Dark Mode",
      description: "Toggle between light and dark themes for comfortable viewing",
      icon: "🌓"
    },
    {
      title: "Component Library",
      description: "Reusable components for consistent design across your application",
      icon: "🧩"
    }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 transition-colors duration-300">
      {/* Hero Section */}
      <motion.section 
        className="relative pt-20 pb-32 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto"
        initial="hidden"
        animate={isVisible ? "visible" : "hidden"}
        variants={staggerChildren}
      >
        <div className="flex flex-col lg:flex-row items-center gap-12">
          <motion.div 
            className="w-full lg:w-1/2 text-center lg:text-left"
            variants={fadeIn}
          >
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-gray-900 dark:text-white mb-6 leading-tight">
              Build Better Apps <span className="text-blue-600 dark:text-blue-400">Faster</span>
            </h1>
            <p className="text-lg md:text-xl text-gray-600 dark:text-gray-300 mb-8 max-w-lg mx-auto lg:mx-0">
              A modern UI component library for Next.js applications with built-in theming, responsive design, and accessibility.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
              <Button 
                variant="primary" 
                size="lg"
                leftIcon={
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M5 12h14M12 5l7 7-7 7" />
                  </svg>
                }
              >
                Get Started
              </Button>
              <Button 
                variant="outline" 
                size="lg"
                onClick={toggleTheme}
                leftIcon={theme === 'dark' ? '🌞' : '🌙'}
              >
                {theme === 'dark' ? 'Light Mode' : 'Dark Mode'}
              </Button>
            </div>
          </motion.div>
          <motion.div 
            className="w-full lg:w-1/2"
            variants={fadeIn}
          >
            <div className="relative h-[300px] sm:h-[400px] w-full">
              <Image
                src="/next.svg"
                alt="Next.js Hero"
                priority
                fill
                style={{ objectFit: 'contain' }}
                className="dark:invert p-6"
              />
            </div>
          </motion.div>
        </div>
      </motion.section>

      {/* Features Section */}
      <section className="py-16 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
        <motion.div 
          className="text-center mb-16"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <h2 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
            Our Components
          </h2>
          <p className="text-lg text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
            Explore our library of reusable components designed for modern web applications
          </p>
        </motion.div>

        <motion.div 
          className="grid grid-cols-1 md:grid-cols-3 gap-8"
          variants={staggerChildren}
          initial="hidden"
          whileInView="visible"
          viewport={{ once: true, margin: "-100px" }}
        >
          {featureItems.map((feature, index) => (
            <motion.div key={index} variants={fadeIn}>
              <Card 
                variant="elevated" 
                hoverEffect 
                className="h-full"
              >
                <Card.Body>
                  <div className="text-4xl mb-4">{feature.icon}</div>
                  <Card.Title className="mb-2">{feature.title}</Card.Title>
                  <Card.Description>{feature.description}</Card.Description>
                </Card.Body>
                <Card.Footer className="flex justify-end">
                  <Button variant="secondary" size="sm">
                    Learn more
                  </Button>
                </Card.Footer>
              </Card>
            </motion.div>
          ))}
        </motion.div>
      </section>

      {/* CTA Section */}
      <motion.section 
        className="py-16 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto"
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        transition={{ duration: 0.5 }}
        viewport={{ once: true }}
      >
        <Card variant="flat" className="bg-blue-600 dark:bg-blue-800 text-white">
          <Card.Body className="text-center py-12 px-4 sm:px-12">
            <h2 className="text-3xl md:text-4xl font-bold mb-6">Ready to get started?</h2>
            <p className="text-lg mb-8 max-w-2xl mx-auto text-blue-100">
              Join thousands of developers building modern applications with our component library.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button 
                variant="outline" 
                size="lg"
                className="border-white text-white hover:bg-white hover:text-blue-600"
              >
                Documentation
              </Button>
              <Button 
                variant="primary" 
                size="lg"
                className="bg-white text-blue-600 hover:bg-blue-50"
              >
                Get Started
              </Button>
            </div>
          </Card.Body>
        </Card>
      </motion.section>

      {/* Footer */}
      <footer className="py-12 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto border-t border-gray-200 dark:border-gray-700">
        <div className="flex flex-col md:flex-row justify-between items-center">
          <div className="mb-4 md:mb-0">
            <Image
              src="/next.svg"
              alt="Logo"
              width={100}
              height={20}
              className="dark:invert"
            />
          </div>
          <div className="flex gap-6">
            <a href="#" className="text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white transition-colors">
              Documentation
            </a>
            <a href="#" className="text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white transition-colors">
              GitHub
            </a>
            <a href="#" className="text-gray-600 hover:text-gray
