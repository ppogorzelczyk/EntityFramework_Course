﻿using DataAnnotations;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FluentAPI.EntityConfigurations
{
    public class CourseConfiguration : EntityTypeConfiguration<Course>
    {
        public CourseConfiguration()
        {
            // 1. Override table name
            ToTable("tbl_Course");

            // 2. Override primary key
            HasKey(c => c.Id);

            // 3. Override properties (alphabetically)
            Property(c => c.Description)
            .IsRequired()
            .HasMaxLength(2000);

            Property(c => c.Name)
            .IsRequired()
            .HasMaxLength(255);

            // 4. Override relationships (alphabetically too)
            HasRequired(c => c.Author)
            .WithMany(a => a.Courses)
            .HasForeignKey(c => c.AuthorId)
            .WillCascadeOnDelete(false);

            HasRequired(c => c.Cover)
           .WithRequiredPrincipal(c => c.Course);

            HasMany(c => c.Tags)
            .WithMany(t => t.Courses)
            .Map(m =>
            {
                m.ToTable("CourseTags");
                m.MapLeftKey("CourseId");
                m.MapRightKey("TagId");
            });           
        }
    }
}
