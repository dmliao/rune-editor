#!/usr/local/bin/jruby

# ZetCode JRuby Swing tutorial
#
# This program uses toggle buttons to
# change the background color of
# a panel.
#
# author: Jan Bodnar
# website: www.zetcode.com
# last modified: December 2010

include Java

import java.awt.Color
import java.awt.Dimension
import java.awt.event.ActionListener
import javax.swing.JToggleButton
import javax.swing.Box
import javax.swing.BoxLayout
import javax.swing.BorderFactory
import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.border.LineBorder
import javax.swing.UIManager


class Example < JFrame
    include ActionListener
    
    def initialize
        super "JToggleButton"
        
        self.initUI
        self.pack
    end
      
    def initUI

        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName())
      
        self.setPreferredSize Dimension.new 280, 200

        bottom = JPanel.new
        bottom.setLayout BoxLayout.new bottom, BoxLayout::X_AXIS
        bottom.setBorder BorderFactory.createEmptyBorder 20, 20, 20, 20

        leftPanel = JPanel.new
        leftPanel.setLayout BoxLayout.new leftPanel, BoxLayout::Y_AXIS

        @display = JPanel.new
        @display.setPreferredSize Dimension.new 110, 110
        @display.setBorder LineBorder.createGrayLineBorder
        @display.setBackground Color.black

        bottom.add @display
            
        redButton = JToggleButton.new "red"
        redButton.addActionListener self
        greenButton = JToggleButton.new "green"
        greenButton.addActionListener self
        blueButton = JToggleButton.new "blue"
        blueButton.addActionListener self
        

        blueButton.setMaximumSize greenButton.getMaximumSize
        redButton.setMaximumSize greenButton.getMaximumSize

        leftPanel.add redButton
        leftPanel.add Box.createRigidArea Dimension.new 25, 7
        leftPanel.add greenButton
        leftPanel.add Box.createRigidArea Dimension.new 25, 7
        leftPanel.add blueButton      

        bottom.add leftPanel
        bottom.add Box.createRigidArea Dimension.new 20, 0

        self.add bottom
        self.pack
      
        self.setDefaultCloseOperation JFrame::EXIT_ON_CLOSE
        self.setSize 300, 200
        self.setLocationRelativeTo nil
        self.setVisible true
    end
    
    def actionPerformed e
                
        color = @display.getBackground
        red = color.getRed
        green = color.getGreen
        blue = color.getBlue

        if e.getActionCommand == "red"
            if red == 0
                red = 255
            else
                red = 0
            end
        end

        if e.getActionCommand == "green"
            if green == 0
                green = 255
            else
                green = 0
            end
        end

        if e.getActionCommand == "blue"
            if blue == 0
                blue = 255
            else
                blue = 0
            end            
        end

        setCol = Color.new red, green, blue
        @display.setBackground setCol        
    end      
end

Example.new