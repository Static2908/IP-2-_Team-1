package com.skillgap.model;

public class Skill {
    private int skillId;
    private String skillName;
    private String category;
    private String description;
    
    // Constructor
    public Skill() {
    }
    
    public Skill(String skillName, String category, String description) {
        this.skillName = skillName;
        this.category = category;
        this.description = description;
    }
    
    // Getters and Setters
    public int getSkillId() {
        return skillId;
    }
    
    public void setSkillId(int skillId) {
        this.skillId = skillId;
    }
    
    public String getSkillName() {
        return skillName;
    }
    
    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Override
    public String toString() {
        return "Skill{" +
                "skillId=" + skillId +
                ", skillName='" + skillName + '\'' +
                ", category='" + category + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
